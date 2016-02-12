//
//  SearchQuery+CoreDataProperties.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-10.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SearchQuery {

    @NSManaged var query: String?
    @NSManaged var results: NSObject?

}
