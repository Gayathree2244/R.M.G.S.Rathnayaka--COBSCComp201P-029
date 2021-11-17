//
//  NIBM_ParkingApp.swift
//  NIBM Parking
//
//  Created by Gayathree Rathnayaka on 2021-11-10.
//

import SwiftUI
import Firebase

@main
struct NIBM_ParkingApp: App {
    
 @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            //NavigationView {
                ContentView()
            //}
        }
    }
}
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_applications: UIApplication, didFinishLaunchingWithOptions launchOptions:
                         [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            
            return true
        }
    }

