//
//  FourSquareAPIClient.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct FSAPIClient {
    private init() {}
    static let shared = FSAPIClient()
    
    func getVenuesFrom(lat: Double, long: Double, query: String, completionHandler: @escaping (Result<Venues, AppError>) -> ()) {
        let urlStr = "https://api.foursquare.com/v2/venues/search?ll=\(lat),\(long)&client_id=\(Secrets.clientKey)&client_secret=\(Secrets.secretsKey)&query=\(query)&v=20191104"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
                print(urlStr)
            case .success(let data):
                    let venues = Venue.getVenues(from: data)
                    completionHandler(.success(venues!))
            }
        }
    }
    
    func getPictureURL(venueID: String, completionHandler: @escaping (Result<[Item], AppError>) -> ()) {
        let urlStr = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(Secrets.clientKey)&client_secret=\(Secrets.secretsKey)&v=20191104&limit=1"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                let photoURL = PictureWrapper.getPhoto(from: data)
         completionHandler(.success(photoURL))
                }
        }
    }
    
}
