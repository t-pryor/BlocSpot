//
//  DataStore.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-06.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit


class DataStore: NSObject {
    
    // singleton
    static let sharedInstance = DataStore()
    

    // variable used to back ..
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    var locationManager = CLLocationManager()
    
    private var privateSpots = [Spot]()
    var allSpots: [Spot] {
        var spotsCopy = [Spot]()
        
        dispatch_sync(self.concurrentSpotQueue) {
            spotsCopy = self.privateSpots
        }
        return spotsCopy
    }
    
    // FIXME: change from implicitly unwrapped
    var region = MKCoordinateRegion!()
    private var currentMKLocalSearch = MKLocalSearch!()
    
    
    var currentSearchQueryAndResults: SearchQueryAndResults? = nil
    
    
    // Concurrency
    private let concurrentSpotQueue = dispatch_queue_create("com.example.spotQueue", DISPATCH_QUEUE_CONCURRENT)

    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    

    
    
    
    
    
    
    func searchQuery(query: String, region: MKCoordinateRegion) -> MKLocalSearchResponse? {
        
        // Cancel any previous searches
        currentMKLocalSearch.cancel()
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = query
        request.region = region
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        currentMKLocalSearch = MKLocalSearch(request: request)
        
        var responseCopy: MKLocalSearchResponse? = nil
        
        
        dispatch_sync(concurrentSpotQueue) {
            self.currentMKLocalSearch.startWithCompletionHandler { (response, error) in
                guard response != nil else {
                    print("Search error: \(error)")
                    return
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
    //            var tempSpotInfos = Array<SpotInfo>()
    //            
    //            for item in response!.mapItems {
    //                let name = item.name
    //                let phoneNumber = item.phoneNumber
    //                let (latitude, longitude) = SpotInfo.convertPlacemarkCoordinatesToLatitudeAndLongitude(item.placemark)
    //                let tempSpotInfo = SpotInfo(name: name, phoneNumber: phoneNumber, latitude: latitude, longitude: longitude)
    //                tempSpotInfos.append(tempSpotInfo)
    //                
    //            }
                
                responseCopy = response
            }
        }
        
        return responseCopy
    }
    
//    
//    func requestSpotsWithSearchQuery(inout search: SearchQueryAndResults, completionClosure: (error: NSError) -> ()) {
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = search.query
//       // request.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(0, 0), 10000, 10000)
//        
//        currentMKLocalSearch = MKLocalSearch(request: request)
//        currentMKLocalSearch.startWithCompletionHandler { (response, error) in
//            
//            guard response != nil else {
//                print("Search error: \(error)")
//                return
//            }
//            
//            // create array to store placemarks returned by search
//            var tempSpotInfos = Array<SpotInfo>()
//            
//            for item in response!.mapItems {
//                let name = item.name
//                let phoneNumber = item.phoneNumber
//                let (latitude, longitude) = SpotInfo.convertPlacemarkCoordinatesToLatitudeAndLongitude(item.placemark)
//                let tempSpotInfo = SpotInfo(name: name, phoneNumber: phoneNumber, latitude: latitude, longitude: longitude)
//                tempSpotInfos.append(tempSpotInfo)
//            }
//            
//            search.searchSpotsResults = tempSpotInfos
//            print("-----------------in startWithCompletionHandler")
//            self.currentSearchQueryAndResults = search
//        }
//        
//        NSNotificationCenter.defaultCenter().postNotificationName("New Search Completed", object: self)
//    }
    
    


    
    
    

    
    
    
    
    
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.example.ExampleCoreDataios9" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("ExampleCoreDataios9", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}

extension DataStore: CLLocationManagerDelegate {
    
    func getCurrentLocation() -> CLLocation? {
        
        // locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        let location = locationManager.location
        //        var coord = CLLocationCoordinate2D()
        //
        //        guard location != nil else {
        //            return nil
        //        }
        //
        //        coord.longitude = location!.coordinate.longitude
        //        coord.latitude = location!.coordinate.latitude
        
        return location
    }

    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        switch status {
//        case .Authorized, .AuthorizedWhenInUse:
//            locationManager.startUpdatingLocation()
//        default:
//            locationManager.stopUpdatingLocation()
//        }
        
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation() // new for iOS9
        }

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let newLocation = locations.last {
//            //newLocation is most recent
//            //extract data to feed to GUI
//            // could return first if need to filter out
//            
//            
//            if newLocation.horizontalAccuracy < 0 {
//                // invalid accuracy
//                return
//            }
//            
//            // numbers in meters
//            if newLocation.horizontalAccuracy > 100 ||
//                newLocation.verticalAccuracy > 50 {
//                    // accuracy radius is so large, we don't want to use it
//                    return
//            }
//            
//        }

    
        if let location = locations.first {
            print("location:: \(location)")
        }
    
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
    
}


    
    
