//
//  ViewController.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var venueCollectionView: UICollectionView!
    
    @IBOutlet weak var searchVenue: UISearchBar!
    
    @IBOutlet weak var searchLocation: UISearchBar!
    
    var currentLocation = CLLocation.init(latitude: 40.7, longitude: -74)
    
    private let locationManager = CLLocationManager()
  
    let searchRadius: CLLocationDistance = 2000
       
    var searchString: String? = nil {
        didSet{
            
        }
    }
    
    private func locationAuthorization(){
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        setUpDelegates()
        locationAuthorization()
        locationManager.delegate = self
        mapView.userTrackingMode = .follow
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    private func setUpDelegates(){
        searchVenue.delegate = self
        searchLocation.delegate = self
    }

}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           print("new locations \(locations)")
           
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("an error occurred: \(error)")
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           print("Authorization status changed to \(status.rawValue)")
           switch status {
           case .authorizedAlways, .authorizedWhenInUse:
               locationManager.requestLocation()
               //call a function to get current location
           default:
               break
           }
       }
}
