//
//  Utils.swift
//  NIBM-Parking
//

import Foundation
class Utils: ObservableObject{
    @Published var isLoggedIn = false;
    @Published var view = "LoginView";
    @Published var tabTag : Int = 1;
}

struct AlertMaker: Identifiable {
    var id: String { msg }
    let msg: String
}

struct Values {
    static let VIP = "vip"
    static let NORMAL = "normal"
    static let RESERVED = "RESERVED"
    static let AVAILABLE = "AVAILABLE"
}

import SwiftUI

struct MyColors {
    static let vipColor = Color("vip")
    static let normalColor = Color("normal")
    static let buttonColor1 = Color("btn1")
    static let buttonColor2 = Color("btn2")
    static let backgroundColor = Color("background")
}

class ViewChanger{
    
    func changeView(util:Utils,view:String,tag:Int) -> Void {
        util.view = view;
        util.tabTag = tag;
    }
}


extension Array{
    func split()->(left:[Element],right:[Element]){
        let ct = self.count;
        let half = ct/2;
        let lSplit = self[0 ..< half];
        let rSplit = self[half ..< ct]
        return (left :Array(lSplit),right:Array(rSplit))
    }
}
