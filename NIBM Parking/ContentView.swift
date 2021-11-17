//
//  ContentView.swift
//  NIBM Parking
//
//  Created by Gayathree Rathnayaka on 2021-11-10.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    
    var body: some View {
        TabView(selection: .constant(1)) {
            HomeView()
                .tabItem {
                    Image(systemName : "house")
                    Text("Home")
                }
            LoginView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Sign In")
                }
            RegisterView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Register")
                }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
