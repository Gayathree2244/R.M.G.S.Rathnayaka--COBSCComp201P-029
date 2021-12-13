//
//  HomeView.swift
//  NIBM-Parking
//

import SwiftUI
import FirebaseDatabase

struct HomeView: View {
    @ObservedObject var utils : Utils
    @State var set1: [DataSnapshot] = [];
    @State var set2: [DataSnapshot] = [];
    
    var controller = FirebaseController();
    
    var body: some View {
        MyColors.backgroundColor.overlay(
        VStack{
            Text("Book Your Parking Slot Now!")
                .fontWeight(.bold).padding(.bottom, 30.0)
            HStack{
                VStack{
                    ForEach(0..<set1.count, id: \.self) { index in
                       
                        let status = self.set1[index].childSnapshot(forPath: "status").value as! String;
                        let name = self.set1[index].childSnapshot(forPath: "name").value as! String;
                        
                        let color = name.contains("N") ? MyColors.normalColor : MyColors.vipColor;
                        VStack{
                                 Text(name)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30.0)
                                 Text(status)
                                    .font(.body).fontWeight(.bold).foregroundColor(.black).padding(0.0)
                            if(status==Values.RESERVED){
                                let user = self.set1[index].childSnapshot(forPath: "user").value as! [String:Any]
                                Text(user["vehicle_no"] as! String)
                                    .fontWeight(.light)
                            }
                                 
                        }.frame(width: 120.0,height: 80.0).background(color).padding(1.0).cornerRadius(8)
                        
                      }
                   
                }.frame(width:150)
                
                VStack{
                    ForEach(0..<set2.count, id: \.self) { index in

                        let status = self.set2[index].childSnapshot(forPath: "status").value as! String;
                        let name = self.set2[index].childSnapshot(forPath: "name").value as! String;
                        let color = name.contains("N") ? MyColors.normalColor : MyColors.vipColor;
                        VStack{
                                 Text(name)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30.0)
                                 Text(status)
                                    .font(.body).fontWeight(.bold).foregroundColor(.black).padding(0.0)
                            if(status==Values.RESERVED){
                                let user = self.set2[index].childSnapshot(forPath: "user").value as! [String:Any]
                                Text(user["vehicle_no"] as! String)
                                    .fontWeight(.light)
                            }

                        }.frame(width: 120.0,height: 80.0).background(color).padding(1.0).cornerRadius(8)

                      }

                }.frame(width:150)
         
            }
            
        }.onAppear(){
            
            
         self.findAll();
            
        }
        )
        .edgesIgnoringSafeArea(.top)
                
    }
    

    
    func findAll(){
        controller.findAll{(success) -> Void in
            let split = success.split();
            self.set1 = split.left;
            self.set2 = split.right;
        }
    }
    
    
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
