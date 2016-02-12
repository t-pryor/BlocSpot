////
////  SearchTableDataProvider.swift
////  BlocSpot
////
////  Created by Tim Pryor on 2016-02-09.
////  Copyright © 2016 Tim Pryor. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class SearchTableDataProvider: NSObject/*, SearchTableDataProviderProtocol*/ {
//    
//    var managedObjectContext: NSManagedObjectContext? = nil
//    weak var tableView: UITableView!
//    private var _fetchedResultsController: NSFetchedResultsController? = nil
//    
//    
//}
//
//
//extension SearchTableDataProvider: UITableViewDataSource {
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.fetchedResultsController.sections?
//    }
//    
////    
//    
//}
//
//extension SearchTableDataProvider: NSFetchedResultsControllerDelegate {
//    
//    var fetchedResultsController: NSFetchedResultsController {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//        
//        let fetchRequest = NSFetchRequest()
//        // Edit the entity name as appropriate.
//        let entity = NSEntityDescription.entityForName("Spot", inManagedObjectContext: self.managedObjectContext!)
//        fetchRequest.entity = entity
//        
//        // Set the batch size to a suitable number.
//        fetchRequest.fetchBatchSize = 20
//        
//        // Edit the sort key as appropriate.
//        let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
//        let sortDescriptors = [sortDescriptor]
//        
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
//        aFetchedResultsController.delegate = self
//        _fetchedResultsController = aFetchedResultsController
//        
//        var error: NSError? = nil
//        do {
//            try _fetchedResultsController!.performFetch()
//        } catch let error1 as NSError {
//            error = error1
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //println("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
//        
//        return _fetchedResultsController!
//    
//    }
//    
//}