//
//  HomeView.swift
//  NIBM Parking
//
//  Created by Hasini Herath on 2021-11-15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Button(action: {}, label:{
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.black.opacity(0.08))
                        .foregroundColor(Color("pink"))
                        .cornerRadius(8)
                }
                )
            }
            
            .padding()
            
            ScrollView(.vertical, showsIndicators: false,content: {
                
                VStack(alignment: .leading,spacing : 15){
                    //Top Display
                    
                    HStack (spacing:10){
                        
                        VStack(alignment: .leading, spacing: 12, content: {
                            (
                                Text("Welcome to NIBM Parking!")
                            )
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            //Button to book a vehicle slot
                            
                          //  Button(action:{}
                                   /*label:{
                                Text("Book Now")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(Color("red"))
                                    .clipShape(Capsule())
                                
                            }*/
                                 
                            NavigationLink("Book Now", destination:LoginView())
                            
                                   
                                       .padding()
                                   
                            //)
                        })
                            .padding(.leading)
                        Spacer(minLength: 0)
                        
                        Image("car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getRect().width/3)
                    }
                    
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 25){
                            
                        }
                        .padding()
                    })
            }
                
                .padding(.vertical)
                
                
                
            })
        }

        //NavigationView {
            //VStack{
                
               // NavigationLink("Sign In", destination:LoginView())
                  //  .padding()
                /*Button(action: {
                    
                    viewModel.signOut()
                    
                }, label: {
                    Text("Sign Out")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.blue)
                        .padding()
                    
                })
              */
            //}
            //.navigationTitle("Welcome to NIBM Parking!")
            
            
       // }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

//Extending view to get Screen Frame
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
