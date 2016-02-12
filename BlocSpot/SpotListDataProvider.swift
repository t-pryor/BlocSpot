//
//  SpotListDataProvider.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-06.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import UIKit
import CoreData

class SpotListDataProvider: NSObject /* , SpotListDataProviderProtocol */ {
    
    var managedObjectContext: NSManagedObjectContext?
    weak var tableView: UITableView!
    private var _fetchedResultsController: NSFetchedResultsController? = nil
    
}






//extension SpotListDataProvider: UITableViewDataSource {
//    
//    
//    
//}

//    
//extension SpotListDataProvider: NSFetchedResultsControllerDelegate {
//        
//    var fetchedResultsController: NSFetchedResultsController {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//        
//        let fetchRequest = NSFetchRequest()
//        let entity = NSEntityDescription.entityForName("Spot", inManagedObjectContext: self.managedObjectContext)
//        fetchRequest.entity = entity
//        
//        // Set the batch size to a suitable number
//        fetchRequest.fetchBatchSize = 20
//        
//        // Edit the sort key as appropriate.
//        let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
//        
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
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
//    }
//    
//    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.beginUpdates()
//    }
//    
//    public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//        case .Insert:
//            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//        case .Delete:
//            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//        default:
//            return
//        }
//    }
//    
//    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: NSManagedObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        switch type {
//        case .Insert:
//            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
//        case .Delete:
//            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//        case .Update:
//            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
//        case .Move:
//            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
//        default:
//            return
//        }
//    }
//    
//    public func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.endUpdates()
//    }

