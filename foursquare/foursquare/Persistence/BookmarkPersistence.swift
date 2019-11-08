//
//  BookmarkPersistence.swift
//  foursquare
//
//  Created by Sam Roman on 11/8/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct BookmarkPersistenceHelper {

    private static var list = [Bookmark]()

    static let manager = BookmarkPersistenceHelper()
    
    func saveBookmark(newArray: [Bookmark]) throws {
        try persistenceHelper.save(updatedElements: newArray)
    }
    
    func getBookmarks() throws -> [Bookmark] {
        return try persistenceHelper.getObjects()
    }

    func deleteBookmark(index: Int) throws {
        return try persistenceHelper.deleteAtIndex(index: index)
}
    

    private let persistenceHelper = PersistenceHelper<Bookmark>(fileName: "venueBookmarks.plist")
    private init() {}
}
