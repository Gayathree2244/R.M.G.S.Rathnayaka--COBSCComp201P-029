//
//  RegisterView.swift
//  NIBM Parking
//
//  Created by Hasini Herath on 2021-11-15.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack{
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action:  {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                       viewModel.signUp(email: email, password:password)
                    }, label:{
                        
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                        
                    })
                }
                .padding()
                
                Spacer()
                
            }
            .navigationTitle("Create an Account")
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .preferredColorScheme(.dark)
    }
}
