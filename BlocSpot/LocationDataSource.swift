//
//  LocationDataSource.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-06.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDataSource: NSObject, CLLocationManagerDelegate {
    
    // singleton
    static let sharedInstance = LocationDataSource()
    var locationManager = CLLocationManager()
    
    
    
    override init() {
        
        super.init() // &*Investigate
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 100.0
        self.locationManager.delegate = self
        
        //&* change this
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let newLocation = locations.last {
            //newLocation is most recent
            //extract data to feed to GUI
            // could return first if need to filter out
            
            
            
            
            if newLocation.horizontalAccuracy < 0 {
                // invalid accuracy
                return
            }
            
            // numbers in meters
            if newLocation.horizontalAccuracy > 100 ||
                newLocation.verticalAccuracy > 50 {
                    // accuracy radius is so large, we don't want to use it
                    return
            }
            
        }
        
        
        
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized, .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    
   
    
    
    
}
