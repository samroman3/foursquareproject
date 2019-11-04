//
//  Venue.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

// MARK: - Venues
struct Venues: Codable {
    let meta: Meta?
    let response: Response?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
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
    let referralID: ReferralID?
    let hasPerk: Bool?
    let venuePage: VenuePage?

    enum CodingKeys: String, CodingKey {
        case id, name, location, categories, delivery
        case referralID = "referralId"
        case hasPerk, venuePage
    }
}

// MARK: - Category
struct Category: Codable {
    let id: ID?
    let name: Name?
    let pluralName: PluralName?
    let shortName: ShortName?
    let icon: CategoryIcon?
    let primary: Bool?
}

// MARK: - CategoryIcon
struct CategoryIcon: Codable {
    let iconPrefix: String?
    let suffix: Suffix?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

enum Suffix: String, Codable {
    case png = ".png"
}

enum ID: String, Codable {
    case the4Bf58Dd8D48988D151941735 = "4bf58dd8d48988d151941735"
    case the4Bf58Dd8D48988D1C1941735 = "4bf58dd8d48988d1c1941735"
    case the4Bf58Dd8D48988D1Cb941735 = "4bf58dd8d48988d1cb941735"
    case the53E0Feef498E5Aac066Fd8A9 = "53e0feef498e5aac066fd8a9"
}

enum Name: String, Codable {
    case foodTruck = "Food Truck"
    case mexicanRestaurant = "Mexican Restaurant"
    case streetFoodGathering = "Street Food Gathering"
    case tacoPlace = "Taco Place"
}

enum PluralName: String, Codable {
    case foodTrucks = "Food Trucks"
    case mexicanRestaurants = "Mexican Restaurants"
    case streetFoodGatherings = "Street Food Gatherings"
    case tacoPlaces = "Taco Places"
}

enum ShortName: String, Codable {
    case foodTruck = "Food Truck"
    case mexican = "Mexican"
    case streetFoodGathering = "Street Food Gathering"
    case tacos = "Tacos"
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

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case sizes, name
    }
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode: String?
    let cc: Cc?
    let neighborhood: String?
    let city: City?
    let state: State?
    let country: Country?
    let formattedAddress: [String]?
    let crossStreet: String?
}

enum Cc: String, Codable {
    case us = "US"
}

enum City: String, Codable {
    case brooklyn = "Brooklyn"
    case newYork = "New York"
    case woodside = "Woodside"
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: Label?
    let lat, lng: Double?
}

enum Label: String, Codable {
    case display = "display"
}

enum State: String, Codable {
    case ny = "NY"
}

enum ReferralID: String, Codable {
    case v1572897478 = "v-1572897478"
}

// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String?
}
