//
//  LoginView.swift
//  NIBM Parking
//
//  Created by Hasini Herath on 2021-11-11.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
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
                    SecureField("Email Address", text: $email)
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
