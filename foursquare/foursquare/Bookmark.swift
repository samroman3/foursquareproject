//
//  Bookmark.swift
//  foursquare
//
//  Created by Sam Roman on 11/8/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

struct Bookmark: Codable {
    var image: Data
    var name: String
    
    var venues: [Venue]?
}
