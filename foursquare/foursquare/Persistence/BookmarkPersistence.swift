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
    
    func saveBookmark(newItem: Bookmark) throws {
        try persistenceHelper.save(newElement: newItem)
    }
    func getBookmarks() throws -> [Bookmark] {
        return try persistenceHelper.getObjects()
    }

    func delete(index: Int) throws {
        return try persistenceHelper.deleteAtIndex(index: index)

}

    private let persistenceHelper = PersistenceHelper<Bookmark>(fileName: "venueBookmarks.plist")
    private init() {}
}
