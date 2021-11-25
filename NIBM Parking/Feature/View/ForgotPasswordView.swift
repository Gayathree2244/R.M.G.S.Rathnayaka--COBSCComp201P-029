

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State var email = ""
    
    @Environment(\.presentationMode) var presentation
    var body: some View {
    
            ZStack {
                
                // Background Color
                Color.white
                    .ignoresSafeArea(edges: .all)
                
                // Main View
                VStack {
                    
                    // Fields
                    VStack(spacing: 20) {
                        TextField("Email", text: $email, prompt: Text("Enter email..."))
                            .font(.title2)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                        
                    }
                    .padding()
                    .padding(.bottom, 8.0)
                    
                    // Buttons
                    VStack(spacing: 16) {
                        
                        // Create Account
                        Button {
                            resetPassword()
                        } label: {
                            Text("Reset password")
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(16)
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                }
                
            }
            // Title
            .navigationTitle("Reset Password")
        
    }
    private func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: email ){
            error in
            
            if let err = error {
                print("No user")
                return
            }
            print("Reset link sent")
            
            
                //back to login page
                presentation.wrappedValue.dismiss()
            
        }
    }
    
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

