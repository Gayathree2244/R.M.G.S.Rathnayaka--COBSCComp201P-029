//
//  FirebaseController.swift
//  NIBM-Parking
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseController{
    var db: DatabaseReference!
    
    func signUp(mail: String, password: String,fname:String,lname: String,vehNo:String,nic:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: mail, password: password) {(res, error) in
            if let user = res?.user {
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let data    =  ["registerid":id,
                                "fname":fname,
                                "lname":lname,
                                "vehicle_no":vehNo,
                                "nic":nic] as [String : Any]
                self.db = Database.database().reference()
                self.db.child("users").child(user.uid).setValue(data)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func login(mail: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: mail, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func forgotPassword(mail: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: mail) { (error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func signOut(){
        try! Auth.auth().signOut();
    }
    
    
    func readUser(completionBlock: @escaping (_ success: [String: Any]) -> Void) {
        
        db = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {
            return
        }
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            let user = data.value as! [String: Any]
            completionBlock(user);
        })
    }
    
    func isLoggedIn(completionBlock: @escaping (_ success: Bool) -> Void) {
        
        db = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {
            completionBlock(false);
            return
        }
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            completionBlock(true);
        })
    }
    
    func findAll(completionBlock: @escaping (_ success: [DataSnapshot]) -> Void) {
         var all: [DataSnapshot] = [];
        db = Database.database().reference()
        var dataset = db.child(Values.NORMAL)
        
        dataset.observe(.value, with:{ (snapshot) in
            all.append(contentsOf: snapshot.children.allObjects as! [DataSnapshot])
        })
        
        dataset = db.child(Values.VIP)
        dataset.observe(.value, with:{ (snapshot) in
            all.append(contentsOf: snapshot.children.allObjects as! [DataSnapshot])
            completionBlock(all);
        })
    }
    
    func findByType(type:String,completionBlock: @escaping (_ success: [String]) -> Void) {
        var slots :[String] = []
        db = Database.database().reference()
        
        let dataset = db.child(type).queryOrdered(byChild: "status").queryEqual(toValue : Values.AVAILABLE)
        dataset.observe(.value, with:{ (snapshot) in
            for snap in snapshot.children {
                slots.append((snap as! DataSnapshot).key)
                completionBlock(slots);
            }
        })
        
    }
    
    func reserveSlot(type: String,id: String,user: Any, completionBlock: @escaping (_ success: Bool) -> Void) {
        db = Database.database().reference()
        db.child(type).child(id).child("user").setValue(user)
        let child = db.child(type).child(id)
        child.updateChildValues(["status":Values.RESERVED])
        completionBlock(true)
        
    }
}
