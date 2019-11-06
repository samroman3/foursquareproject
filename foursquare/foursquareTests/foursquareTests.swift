//
//  foursquareTests.swift
//  foursquareTests
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import XCTest
import MapKit
import CoreLocation
@testable import foursquare

class foursquareTests: XCTestCase {
    
    
    func testVenueModel() {
        let testData = BundleManager.getDataFromBundle(withName: "VenueTest", andType: "json")
        let testVenues = Venue.getVenues(from: testData)
        
        XCTAssert(testVenues != nil, "testvenues is empty")
        
    }

}
