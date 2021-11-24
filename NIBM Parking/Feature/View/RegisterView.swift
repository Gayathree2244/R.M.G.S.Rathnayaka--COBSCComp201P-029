//
//  RegisterView.swift
//  NIBM Parking
//
//  Created by Hasini Herath on 2021-11-15.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State var uName = ""
    @State var email = ""
    @State var password = ""
    @State var vno = ""
    @State var nic = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack{
                    
                    TextField("User Name", text: $uName)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    TextField("NIC No", text: $nic)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    TextField("Vehicle No", text: $vno)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    
                    
                    Button(action:  {
                        //AddInfo(UserName: String, Email:String, VehicleNo: //String, Password: String)
                        
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                       
                        
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
                Spacer()
                
            }
            .navigationTitle("Create an Account")
        }
        
        
    }
    func AddInfo(UserName: String, Email:String, VehicleNo: String, Password: String){
        let db = Firestore.firestore()
        db.collection("Users").document().setData(["User Name": UserName, "Email": Email, "Vehicle No": VehicleNo,"Password": Password])
    }
    
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .preferredColorScheme(.dark)
    }
}
