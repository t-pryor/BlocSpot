//
//  POITests.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-01-13.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import XCTest
@testable import BlocSpot
import CoreData

class SpotTests: XCTestCase {
    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
////        let testSpot2 = LocationDataSource.sharedInstance.createSpotWithTitle("TestSpot2", subtitle: "testsub2", latitude: 45, longitude: 45, category: .Restaurants)
////        let testSpot3 = LocationDataSource.sharedInstance.createSpotWithTitle("TestSpot3", subtitle: "testsub3", latitude: 45, longitude: 45, category: .Restaurants)
//        // LocationDataSource.sharedInstance.saveContext()
//    
//        
//    
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    
////---
//    func testLocationDataSoureReturnsSingleton() {
//        
//        // test that there is only one instance of the LocationDataSource sharedInstance
//        let lds1 = LocationDataSource.sharedInstance
//        let lds2 = LocationDataSource.sharedInstance
//        
//        XCTAssertEqual(lds1, lds2)
//    }
//    
//    
////---
//  //  func test
//    
//    
//    
//    
////---
//    func testCreatingSpot() {
//        
//       // let testSpot = Spot(title: "McDonalds", subtitle: "99 Billion Served", latitude: 45, longitude: 45, category: .Restaurants)
//       LocationDataSource.sharedInstance.createSpotWithTitle("TestCreatingSpot", subtitle: "99 Billion Served", latitude: 45, longitude: 45, category: .Restaurants)
//        
//        XCTAssert(LocationDataSource.sharedInstance.allSpots.contains( { $0.title == "TestCreatingSpot" } ))
//        
//    }
//    
//
////---
//    func testLoadingSpotsFromCoreData() {
//        
//        var results = [Spot]()
//        
//        LocationDataSource.sharedInstance.createSpotWithTitle("TestFetchingSpot", subtitle: "99 Billion Served", latitude: 45, longitude: 45, category: .Restaurants)
//        
//        results = LocationDataSource.sharedInstance.fetchSpotFromStoreWithTitle("TestFetchingSpot")
//        XCTAssert(results.contains( { $0.title == "TestFetchingSpot" } ))
//        
//        print(results)
//        print(LocationDataSource.sharedInstance.allSpots)
//    }
//    
//    
//    
////---
//    
//    
//
//    
    
    
    
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
