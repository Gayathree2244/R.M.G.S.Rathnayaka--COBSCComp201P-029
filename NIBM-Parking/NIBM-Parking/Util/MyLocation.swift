//
//  MyLocation.swift
//  NIBM-Parking
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class MyLocation: NSObject, CLLocationManagerDelegate,ObservableObject {

    private let location = CLLocationManager()
    @Published var curStatus: CLAuthorizationStatus?
    @Published var lastLoc: CLLocation?
    @Published var INRANGE = false;
    

    
    override init() {
        super.init()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestAlwaysAuthorization()
        location.startUpdatingLocation()
    }

    
    var statusCode: Int {
        guard let status = curStatus else {
            return 0
        }
        
        switch status {
        case .notDetermined: return 0
        case .authorizedWhenInUse: return 1
        case .authorizedAlways: return 1
        case .restricted: return 0
        case .denied: return 0
        default: return 0
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.curStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLoc = location
        let NIBM = CLLocation(latitude: Values.LATI_NIBM, longitude: Values.LONG_NIBM)
        let diff = NIBM.distance(from: location)
        INRANGE = diff <= Values.RANGE_KM ? true : false
    }
}

