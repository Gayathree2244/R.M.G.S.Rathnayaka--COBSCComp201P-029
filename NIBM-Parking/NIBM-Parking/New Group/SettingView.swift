//
//  SettingView.swift
//  NIBM-Parking
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var utils : Utils
    @State var name = "";
    @State var vehicleNo = "";
    @State var email = "";
    @State var nic = "";
    @State var regid = "";
    
    var controller = FirebaseController();
    
    var viewChanger = ViewChanger();
    
    func getUser(){
        controller.readUser() {(success) -> Void in
                let regid = success["registerid"] as! Int64;
                self.regid = String(regid);
            let frName = success["fname"] as! String
            let laName = success["lname"] as! String
            self.name =  frName+" "+laName
                self.vehicleNo = success["vehicle_no"] as! String
                self.nic = success["nic"] as! String
        }
    }
    
    var body: some View {
        MyColors.backgroundColor.overlay(
            VStack{
                Text("My info")
                    .fontWeight(.bold).padding(.top, 50.0)
                HStack( spacing: 70){
                    VStack(alignment: .leading){
                        Text("Name :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 15.0)
                        Text("NIC :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                        Text("Registration No :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                        Text("Vehicle No :")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 40.0)
                    }
                    
                    VStack(alignment: .leading){
                        Text(name)
                            .fontWeight(.semibold)
                            .padding(.top, 15.0)
                        Text(nic)
                            .fontWeight(.semibold)
                            .padding(.top, 40.0)
                        Text(regid)
                            .fontWeight(.semibold)
                            .padding(.top, 40.0)
                        Text(vehicleNo)
                            .fontWeight(.semibold)
                            .padding(.top, 40.0)
                    }
                    
                }.shadow(radius: 10 )
                .padding([.leading, .bottom, .trailing], 20.0).foregroundColor(.black)
                
                Spacer()
                
                Button(action:{
                    controller.signOut()
                    utils.isLoggedIn = false;
                    viewChanger.changeView(util: utils, view: "LoginView", tag: 4)
                    
                }, label:{
                    Text("Log Out").foregroundColor(.white).padding().frame(width: 120.0, height: 40.0).background(MyColors.buttonColor2).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                })
                .padding(.bottom, 100.0)

            }.padding(.top, 20.0).onAppear(){
                self.getUser()
            }
            
        ).edgesIgnoringSafeArea(.all)
    }
    
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
