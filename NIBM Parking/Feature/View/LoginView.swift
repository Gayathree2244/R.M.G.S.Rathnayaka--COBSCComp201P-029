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
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
       
            
        
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack{
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action:  {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                       viewModel.signIn(email: email, password:password)
                    }, label:{
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                        
                    })
                    if (viewModel.signedIn == true) {
                        HomeView()
                        
                    }
                    
                    NavigationLink("Create Account", destination:RegisterView())
                        .padding()
                    
                    NavigationLink("Forgot Password", destination:ForgotPasswordView())
                        .padding()
                    
                    .padding(.all)
                                    }
                
                .padding()
                
                Spacer()
                
            }
            .navigationTitle("Sign In")
            .padding()
           
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .preferredColorScheme(.dark)
            LoginView()
        }
    }
}
