//
//  VenuePicture.swift
//  foursquare
//
//  Created by Sam Roman on 11/5/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

// MARK: - PictureWrapper
struct PictureWrapper: Codable {
    let meta: PictureMeta
    let response: PictureResponse
    
    static func getPhoto(from jsonData: Data) -> [Item] {
        do {
            let data = try JSONDecoder().decode(PictureWrapper.self, from: jsonData)
            return data.response.photos.items
        } catch {
            print("Decoding error: \(error)")
            return [Item]()
        }
    }
}
// MARK: - Meta
struct PictureMeta: Codable {
    let code: Int?
    let requestId: String?

}
// MARK: - Response
struct PictureResponse: Codable {
    let photos: Photos
}
// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let items: [Item]
    let dupesRemoved: Int?
}
// MARK: - Item
struct Item: Codable {
    let id: String
    let createdAt: Int?
    let prefix: String
    let suffix: String
    let width, height: Int?
//
//    let checkin: Checkin
//    let visibility: String?
    
 
    func returnPictureURL() -> String? {
       return "\(prefix)original\(suffix)"
    }
}
//// MARK: - Checkin
//struct Checkin: Codable {
//    let id: String?
//    let createdAt: Int?
//    let type: String?
//    let timeZoneOffset: Int?
//}

