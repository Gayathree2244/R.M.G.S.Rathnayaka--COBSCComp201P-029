//
//  ContentView.swift
//  NIBM Parking
//
//  Created by Gayathree Rathnayaka on 2021-11-10.
//

import SwiftUI
import FirebaseAuth


class AppViewModel: ObservableObject {
    
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    //Creating Sign in Function
    func signIn(email:String, password:String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
            return
        }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
            
        }
    }
    //Register Function
    func signUp(email:String, password:String) {
        auth.createUser(withEmail: email, password:password){ [weak self] result, error in guard result != nil, error == nil else {
            return
        }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }           }
    }
    // Sign Out Function
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
    
    
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        /*
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
                     
                 }         */
        
        NavigationView {
            HomeView()
            
            if viewModel.signedIn{
                
                /*VStack{
                   
                    Text("You are Signed In")
                    
                    Button(action: {
                        
                        viewModel.signOut()
                        
                    }, label: {
                        Text("Sign Out")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(Color.blue)
                            .padding()
                        
                    })
                  
                }
                 */
                
            }
           
            else {
                LoginView()
                
            }
        }
        
               .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
            
        }
        
       
    }

    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

/*struct CircleTab : View {
    var body : some View {
        
        HStack{
            
            Button(action:
 
            )
        }
    }
}
*/
