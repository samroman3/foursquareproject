//
//  Venue.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

// MARK: - Venues
struct Venues: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
    let delivery: Delivery?
    let referralID: String?
    let hasPerk: Bool?
    let venuePage: VenuePage?

    enum CodingKeys: String, CodingKey {
        case id, name, location, categories, delivery
        case referralID = "referralId"
        case hasPerk, venuePage
    }
    
    static func getVenues(from jsonData: Data) -> [Venue]? {
        do {
            let data = try JSONDecoder().decode(Venues.self, from: jsonData)
            return data.response?.venues
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }
}

// MARK: - Category
struct Category: Codable {
    let id: String?
    let name: String?
    let pluralName: String?
    let shortName: String?
    let icon: CategoryIcon?
    let primary: Bool?
}

// MARK: - CategoryIcon
struct CategoryIcon: Codable {
    let iconPrefix: String?
    let suffix: String?


}





// MARK: - Delivery
struct Delivery: Codable {
    let id: String?
    let url: String?
    let provider: Provider?
}

// MARK: - Provider
struct Provider: Codable {
    let name: String?
    let icon: ProviderIcon?
}

// MARK: - ProviderIcon
struct ProviderIcon: Codable {
    let iconPrefix: String?
    let sizes: [Int]?
    let name: String?

   
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode: String?
    let cc: String?
    let neighborhood: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]?
    let crossStreet: String?
}




// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}


// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String?
}


struct BundleManager {
    static func getDataFromBundle(withName name: String, andType type: String) -> Data {
        guard let pathToData = Bundle.main.path(forResource: name, ofType: type) else {
            fatalError("\(name).\(type) file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }
}
