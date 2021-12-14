//
//  RegisterView.swift
//  NIBM-Parking
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var utils : Utils
    @State var fname = "";
    @State var lname = "";
    @State var vehicleNo = "";
    @State var email = "";
    @State var nic = "";
    @State var password = "";
    
    @State private var alert: AlertMaker?;
    
    var controller = FirebaseController();
    var validator = Validator();
    var viewChanger = ViewChanger();
    
    func getUser(){
        controller.isLoggedIn() {(success) -> Void in
            utils.isLoggedIn = success
        }
    }
    
    var body: some View {
        MyColors.backgroundColor.overlay(
            GeometryReader{ geometry in
                
                ScrollView(.vertical){
                    VStack(alignment: .center){
                      
                        VStack{
                            Text("Create Account")
                                .fontWeight(.bold).padding(.all, 20)
                            HStack(spacing: 25){
                                VStack(alignment: .leading){
                                Text("Email :")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading).frame(height: 50.0)
                                Text("Password :")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading).frame(height: 50.0)
                                }
                                VStack(alignment: .leading){
                                    TextField("",text: $email).keyboardType(.emailAddress)                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                                    
                                    SecureField("",text: $password)
                                        .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                                }
                            }
                            
                            HStack(spacing: 25){
                                
                                VStack(alignment: .leading){
                                    Text("First Name :")
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading).frame(height: 50.0)
                                    Text("Last Name :")
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading).frame(height: 50.0)
                                    Text("NIC :")
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading).frame(height: 50.0)
                                    Text("Vehicle No:")
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.leading).frame(height: 50.0)
                                }
                                
                                VStack(alignment: .leading){
                                    TextField("",text: $fname)
                                        .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                                    
                                    TextField("",text: $lname)
                                        .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                                    
                                    TextField("",text: $nic)
                                        .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                                    
                                    TextField("",text: $vehicleNo)
                                        .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                                }
                            }
                        }.padding(.top, 20.0)
                        
                        
                        
                       
                        VStack{
                               
                              Button(action:{
                                                                
                                if(email.isEmpty){
                                    alert = AlertMaker(msg: "Invalid Email");
                                    return;
                                }else{
                                    if(!validator.checkEmail(email)){
                                        alert = AlertMaker(msg: "Email Format Invalid");
                                        return;
                                    }
                                }
                                
                                if(password.isEmpty){
                                    alert = AlertMaker(msg: "Please Enter Password");
                                    return;
                                }
                                if(!validator.checkPassword(password)){
                                    alert = AlertMaker(msg: "Password at least 8 characters");
                                    return;
                                }
                                if(fname.isEmpty || lname.isEmpty){
                                    alert = AlertMaker(msg: "Please Enter Name");
                                    return;
                                }
                                if( nic.isEmpty){
                                    alert = AlertMaker(msg: "Please Enter NIC");
                                    return;
                                }
                                if(vehicleNo.isEmpty){
                                    alert = AlertMaker(msg: "Please Enter Vehicle No");
                                    return;
                                }

                                controller.signUp(mail: email, password: password, fname: fname,lname:lname, vehNo: vehicleNo, nic: nic) {(success) in
                                    if(success){
                                        alert = AlertMaker(msg: "Success");
                                        viewChanger.changeView(util: utils, view: "LoginView", tag: 4)
                                    }else{
                                        alert = AlertMaker(msg: "Failed");
                                    }
                                }
                              }, label:{
                                Text("Register").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(MyColors.buttonColor1).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                              }).alert(item: $alert) { con in
                                Alert(title: Text(con.msg))
                            }.padding(.top, 5.0)
                              Spacer()
                              Button(action:{
                                utils.isLoggedIn = false
                                viewChanger.changeView(util: utils, view: "LoginView", tag: 4)
                              }, label:{
                                Text("Back to Login").foregroundColor(.white).padding().frame(width: 150.0, height: 40.0).background(MyColors.buttonColor2).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                              })
                              .padding(.top, 20.0)
                        }
                        
                    }.frame(width: geometry.size.width)
                }
            }.onAppear {
                self.getUser();
            }
        ).edgesIgnoringSafeArea(.all)
    }
    
   
    
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
