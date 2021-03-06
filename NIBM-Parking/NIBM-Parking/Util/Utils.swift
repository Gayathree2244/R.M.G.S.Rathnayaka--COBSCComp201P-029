//
//  Utils.swift
//  NIBM-Parking
//

import Foundation
class Utils: ObservableObject{
    @Published var isLoggedIn = false;
    @Published var view = "LoginView";
    @Published var tabTag : Int = 1;
}

struct AlertMaker: Identifiable {
    var id: String { msg }
    let msg: String
}

struct Values {
    static let VIP = "vip"
    static let NORMAL = "normal"
    static let RESERVED = "RESERVED"
    static let AVAILABLE = "AVAILABLE"
    static let LATI_NIBM: Double = 79.87669102758714;
    static let LONG_NIBM: Double = 6.881555729567537;
    static let RANGE_KM: Double = 1000;
}

import SwiftUI

struct MyColors {
    static let vipColor = Color("vip")
    static let normalColor = Color("normal")
    static let buttonColor1 = Color("btn1")
    static let buttonColor2 = Color("btn2")
    static let backgroundColor = Color("background")
}

class ViewChanger{
    
    func changeView(util:Utils,view:String,tag:Int) -> Void {
        util.view = view;
        util.tabTag = tag;
    }
}


extension Array{
    func split()->(left:[Element],right:[Element]){
        let ct = self.count;
        let half = ct/2;
        let lSplit = self[0 ..< half];
        let rSplit = self[half ..< ct]
        return (left :Array(lSplit),right:Array(rSplit))
    }
}

class Validator{
    func checkEmail(_ email: String) -> Bool {
        let mail = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return mail.evaluate(with: email)
    }
    
    
    func checkPassword(_ password: String) -> Bool {
        if  8 > password.count {
            return false
        } else {
            return true;
        }
    }
}
