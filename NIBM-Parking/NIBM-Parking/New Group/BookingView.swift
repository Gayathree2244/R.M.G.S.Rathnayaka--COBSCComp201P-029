//
//  BookingView.swift
//  NIBM-Parking
//

import SwiftUI
import CodeScanner

struct BookingView: View {
    @ObservedObject var utils : Utils
    @State var vehicleNo = "";
    @State var regid = "";
    @State var loggedUser: [String: Any] = ["":""];
    @State private var alert: AlertMaker?;
    var controller = FirebaseController();
    var viewChanger = ViewChanger();
    @ObservedObject var location = MyLocation();
    @State var qrScannner = false;
    @State var slots: [String] = [];
    @State private var slot_index = 0;
    @State var typeIndex = 0
    @State var btn_disable = true;
    @State var slotType = Values.NORMAL
    var qrView : some View{
        CodeScannerView(
            codeTypes: [.qr],
            completion: {res in
                if case let .success(code) = res{
                    self.qrScannner = false
                    if let i = self.slots.firstIndex(of:code) {
                        self.slot_index = i;
                    }
                }
            })
    }
    
    var body: some View {
        
        MyColors.backgroundColor.overlay(

        VStack{
            Text("Booking")
                .fontWeight(.bold)
            HStack( spacing: 50){
                VStack(alignment: .leading){
                    Text("Registration No :")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text("Vehicle No :")
                        .fontWeight(.semibold).padding(.top,20)
                        .multilineTextAlignment(.leading)
                }
                
                VStack(alignment: .leading){
                    Text(regid)
                        .fontWeight(.semibold)
                    Text(vehicleNo)
                        .fontWeight(.semibold).padding(.top , 20)
                }
                
            }.padding(.all,10).shadow(radius: 10 )
            .padding(.all, 20.0).foregroundColor(.black)
            
            
            VStack{
                HStack(){
                    Text("Slot Type :")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading).padding(.leading,60).padding(.bottom,50)
                    Picker("Picker",selection: Binding(
                                get:{self.typeIndex},
                                set:{self.typeIndex = $0
                                     self.getByType(id: $0);
                                }), content:{
                            Text("Normal").tag(0)
                            Text("VIP").tag(1)})
                        .frame(height: 30.0).padding(.bottom,50)
                }.padding(.top,50)
                HStack(){
                    Text("Slot No :")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading).padding(.leading,60).padding(.top,60)
                    
                Picker(selection: $slot_index ,label: Text("Picker")) {
                    ForEach(0..<slots.count, id: \.self) { index in
                            Text("\(self.slots[index])")
                    }
                }.frame(height: 30.0).padding(.top,60)
                }
                
              
                Spacer()
                HStack( spacing: 10){
                    
                    Button(action:{
                        if(!btn_disable){
                            
                            if(location.statusCode==0){
                                alert = AlertMaker(msg: "Please Enable Location");
                                return;
                            }else{
                                if(!location.INRANGE){
                                    alert = AlertMaker(msg: "Booking is available within 1km to parking area");
                                    return;
                                }
                            }
                            
                            btn_disable = true;
                            let id = slots[slot_index];                            
                            controller.reserveSlot(type: slotType,id: id, user: loggedUser) {(success) in
                                if(success){
                                    alert = AlertMaker(msg: "Succesfully Reserved");
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.getByType(id:typeIndex);
                                    }
                                }
                            }
                        }
                        
                    }, label:{
                        Text("Reserve").fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 120.0, height: 40.0).background(MyColors.buttonColor1).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                    }).disabled(btn_disable).alert(item: $alert) { con in
                        Alert(title: Text(con.msg))
                    }
                    
                    Button(action:{
                       self.qrScannner = true;
                    }, label:{
                        Text("Scan QR").fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 120.0, height: 40.0).background(MyColors.buttonColor1).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                    })
                    
                    Button(action:{
                        controller.signOut()
                        utils.isLoggedIn = false;
                        viewChanger.changeView(util: utils, view: "LoginView", tag: 4)
                        
                    }, label:{
                        Text("Log Out").foregroundColor(.white).padding().frame(width: 120.0, height: 40.0).background(MyColors.buttonColor2).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                    })
                }.padding(.bottom,50)
            }
                
            }.sheet(isPresented: $qrScannner) {
            self.qrView
        }.padding(.top,50).onAppear(){
            self.getUser();
            self.getByType(id: 0);
        }).edgesIgnoringSafeArea(.top)
    }
    

    func getUser(){
        controller.readUser() {(success) -> Void in
            let regid = success["registerid"] as! Int64;
            self.regid = String(regid);
            self.vehicleNo = success["vehicle_no"] as! String
            self.loggedUser = success
        }
    }
    
    func getByType(id:Int){
        if(id==1){
            self.slotType = Values.VIP
        }else{
            self.slotType = Values.NORMAL
        }
        controller.findByType(type: slotType) {(success) -> Void in
            self.slots = success;
        }
        btn_disable = false;
    }
    
    
 
}

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView()
//    }
//}
