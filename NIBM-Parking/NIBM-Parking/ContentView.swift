//
//  ContentView.swift
//  NIBM-Parking
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var utils = Utils();
    
    var body: some View {
        TabView(selection: $utils.tabTag) {
            HomeView(utils: utils)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
            if(utils.isLoggedIn){
                BookingView(utils: utils).tabItem {
                            Image(systemName: "book")
                            Text("Booking")
                    }.tag(2)
                SettingView(utils: utils).tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.tag(3)
            }else{
                if(utils.view=="LoginView"){
                    LoginView(utils: utils).tabItem {
                                Image(systemName: "person")
                                Text("Login")
                        }.tag(4)
                }else if(utils.view=="RegisterView"){
                    RegisterView(utils: utils).tabItem {
                                Image(systemName: "person")
                                Text("Register")
                            }.tag(5)

                }else if(utils.view=="FPasswordView"){
                    ForgotPasswordView(utils: utils).tabItem {
                                Image(systemName: "person")
                                Text("Reset Password")
                            }.tag(6)
                }
            }
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

