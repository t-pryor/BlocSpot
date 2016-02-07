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

class LocationDataProvider: NSObject, CLLocationManagerDelegate
{
    
    
    // singleton
    static let sharedInstance = LocationDataProvider()
    
    var managedObjectContext: NSManagedObjectContext?
    weak var tableView: UITableView!
    // back the fetchedResultsController with an optional
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
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
    
    
    
}
