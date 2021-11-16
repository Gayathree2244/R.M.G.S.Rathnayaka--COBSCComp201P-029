//
//  LoginView.swift
//  NIBM Parking
//
//  Created by Hasini Herath on 2021-11-11.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView {
            VStack {
                Image("Login")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack{
                    TextField("Email Address", text: $email)
                        .padding()
                    SecureField("Password", text: $password)
                        .padding()
                }
                .padding()
                
            }
            .navigationTitle("Sign In")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
