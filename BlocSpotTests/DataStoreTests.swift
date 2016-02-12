//
//  DataStoreTests.swift
//  BlocSpot
//
//  Created by Tim Pryor on 2016-02-08.
//  Copyright © 2016 Tim Pryor. All rights reserved.
//

import XCTest
@testable import BlocSpot

class DataStoreTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSharedInstance() {
        let instance = DataStore.sharedInstance
        XCTAssertNotNil(instance, "sharedInstance should not be nil")
    }
    
    func testSharedInstanceIsUnique() {
        // Note: Given the private initializer in DataStore.swift,
        // there is no way to call the store other than through the sharedInstance.
        
        let instance1 = DataStore.sharedInstance
        let instance2 = DataStore.sharedInstance
        XCTAssertTrue(instance1 === instance2, "There should be only one sharedInstance object")
    }
    
    func testSharedInstanceForThreadSafety() {
        var instance1: DataStore!
        var instance2: DataStore!
        
        let expectation1 = expectationWithDescription("Instance 1")
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
            instance1 = DataStore.sharedInstance
            expectation1.fulfill()
        }
        
        let expectation2 = expectationWithDescription("Instance 2")
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
            instance2 = DataStore.sharedInstance
            expectation2.fulfill()
        }
        
        waitForExpectationsWithTimeout(1.0, handler: { (_) in
            XCTAssertTrue(instance1 === instance2)
        })
    }
    
    func testRequestSpotsWithSearchQuery() {
        var dataStore = DataStore.sharedInstance
        
        //var error = NSError.self
        
        
        
        let expectation = expectationWithDescription("Testing asychronous search")
        
        
        var testSearch = SearchQueryAndResults(query: "McDonalds", searchSpotsResults: [])
        dataStore.requestSpotsWithSearchQuery(&testSearch) { _ in
            
        }
        
        expectation.fulfill()
        
        waitForExpectationsWithTimeout(10, handler: { (_) in
            //assert
        
        })
        
        
        print(testSearch)
    
    XCTAssertTrue(!testSearch.searchSpotsResults.isEmpty)
    
    
    }
    
    
    
    
    
    
    
    
    

}
