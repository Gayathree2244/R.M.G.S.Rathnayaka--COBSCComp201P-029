//
//  LoginView.swift
//  NIBM-Parking
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var utils : Utils
    @State var email = "";
    @State var password = "" ;
    
    @State private var alert: AlertMaker?;
    var controller = FirebaseController();
    var viewChanger = ViewChanger();
    
    func getUser(){
        controller.isLoggedIn() {(success) -> Void in
            utils.isLoggedIn = success
        }
    }
    var body: some View {
        MyColors.backgroundColor.overlay(
            VStack(alignment: .center){
                Text("Sign In")
                    .fontWeight(.bold).padding(.bottom, 20)
                HStack(spacing: 20){
                    VStack(alignment: .leading){
                    Text("Email :")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading).frame(height: 50.0)
                    Text("Password :")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading).frame(height: 50.0)
                    }
                    
                    VStack(alignment: .leading){
                    
              
                    TextField("",text: $email).keyboardType(.emailAddress).frame(width: 200.0, height: 40.0).background(Color(.secondarySystemBackground))
                    
                     SecureField("",text: $password).frame(width: 200.0, height: 40.0).background(Color(.secondarySystemBackground))
                    }
                    
                }
                
                
                
                Button(action:{
                    controller.login(mail: email, password: password) {(success) in

                        if(success){
                            utils.isLoggedIn = true;
                        }else{
                            alert = AlertMaker(msg: "Email or Password Invalid");
                        }
                    }
                    
                }, label:{
                    Text("Sign In").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 40.0).background(MyColors.buttonColor1).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                }).alert(item: $alert) { con in
                    Alert(title: Text(con.msg))
                }.padding(.top, 20.0)
                
                Button(action:{
                    viewChanger.changeView(util: utils, view: "RegisterView", tag: 5)
                    
                }, label:{
                    Text("Sign Up").font(.title).fontWeight(.medium).foregroundColor(.white).padding().frame(width: 150.0, height: 40.0).background(MyColors.buttonColor2).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                })
                .padding(.top, 30.0)

                Spacer()
                Button(action:{
                    viewChanger.changeView(util: utils, view: "FPasswordView", tag: 6)
                }, label:{
                    Text("Forget Password").fontWeight(.semibold).padding()
                }).accessibility(identifier: "forPassBtn")
                Button(action:{
                    
                }, label:{
                    Text("Terms & Conditions").fontWeight(.regular).padding()
                })

            }
            .padding(50.0)
            .onAppear {
                self.getUser();
            }
        ).edgesIgnoringSafeArea(.all)
    }
    
    
    
}


//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
