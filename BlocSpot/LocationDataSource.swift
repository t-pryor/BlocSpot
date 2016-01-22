//
//  LocationDataSource.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-06.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class LocationDataSource: NSObject, CLLocationManagerDelegate
{
    
    // singleton
    static let sharedInstance = LocationDataSource()
    
    // Core Location variables
    var locationManager = CLLocationManager()
    
    // Spot
    private var privateSpots = [Spot]()
    
    var allSpots: [Spot] {
        var spotsCopy = [Spot]()
        
        dispatch_sync(self.concurrentSpotQueue) {
            spotsCopy = self.privateSpots
        }
        return spotsCopy
    }
    
    
    // Concurrency
    private let concurrentSpotQueue = dispatch_queue_create("com.example.spotQueue", DISPATCH_QUEUE_CONCURRENT)
    
    
    override private init() {
        super.init() // &*Investigate
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 100.0
        self.locationManager.delegate = self
        
        //&* change this
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    
// MARK: Spot Methods
    
//---
    func loadSpotsIntoDataSourceAtStartup() {
        
        var spotsArrayFromCoreData = [Spot]()
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Spot", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entityDescription
        
        do {
             spotsArrayFromCoreData = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Spot]
    
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        for spot in spotsArrayFromCoreData {
            print(spot)
        }
        
        self.privateSpots = spotsArrayFromCoreData
    }

//---
    func fetchSpotFromStoreWithTitle(title: String) -> [Spot] {
        
        var spotsArrayCopy = [Spot]()
        
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Spot", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entityDescription
        
        
        let predicate = NSPredicate(format:"title = '\(title)'")
        fetchRequest.predicate = predicate
        
        do {
            spotsArrayCopy = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Spot]
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        for spot in spotsArrayCopy {
            print(spot)
        }
        
        return spotsArrayCopy
    }
    
//---
    func createSpotWithTitle(title: String?, subtitle: String?, latitude: Double?, longitude: Double?, category: Spot.Category)  {
        let managedSpot = Spot(title: title, subtitle: subtitle, latitude: latitude, longitude: longitude, category: category)
        self.privateSpots.append(managedSpot)
        self.saveContext()
        
    }
    
    
// MARK: - Search Methods
    
//---
  //  func saveSearch() {
        
 //   }
    
//---
    //func
   
    
// MARK: - CLLocation Methods
    
//---
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
    
//---
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized, .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.example.BlocSpot" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("BlocSpot", withExtension: "momd")!
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
