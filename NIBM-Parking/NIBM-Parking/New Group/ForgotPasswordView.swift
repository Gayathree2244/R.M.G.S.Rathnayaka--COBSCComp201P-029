//
//  ForgotPasswordView.swift
//  NIBM-Parking
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var utils : Utils
    @State var email = "";
    
    @State private var alert: AlertMaker?;
    
    var controller = FirebaseController();
    var viewChanger = ViewChanger();
    
    
    var body: some View {
        Color("background").overlay(
            VStack(alignment: .center){
                
                Text("Email")
                    .font(.title)
                TextField("",text: $email).accessibility(identifier: "emailTxt")
                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
                
                VStack{
                      Button(action:{
                        controller.forgotPassword(mail: email) {(success) in
                            if(success){
                                alert = AlertMaker(msg: "Success");
                            }
                        }
                            
                      }, label:{
                        Text("Submit").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(MyColors.buttonColor2).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                      }).accessibility(identifier: "subBtn").alert(item: $alert) { con in
                        Alert(title: Text(con.msg))
                    }.padding(.top, 5.0)
                    
                      Spacer()
                      Button(action:{
                        viewChanger.changeView(util: utils, view: "LoginView", tag: 4)
                      }, label:{
                        Text("Back to Login").foregroundColor(.white).padding().frame(width: 150.0, height: 30.0).background(MyColors.buttonColor2).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                      })
                      .padding(.bottom, 100.0)
                }
        
        
            }
            .padding(.top, 30.0)
        
        ).edgesIgnoringSafeArea(.all)
        
              
    }
}


//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}
