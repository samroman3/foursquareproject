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
    
    
    var currentLocation = CLLocationCoordinate2D.init(latitude: 40.6782, longitude: -73.9442) {
        didSet {
            self.loadVenues(string: self.venueString ?? "", lat: self.currentLocation.latitude, long: self.currentLocation.latitude)
            self.venueCollectionView.reloadData()
            
        }
    }
    
    var venues = [Venue]() {
        didSet {
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)
            for i in venues {
               let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: i.location?.lat ?? 40.6782, longitude: i.location?.lng ?? -73.9442)
                newAnnotation.title = i.name
                self.mapView.addAnnotation(newAnnotation)
                
            }
            
            self.venueCollectionView.reloadData()
        }
    }
    
    private let locationManager = CLLocationManager()
    
    let searchRadius: CLLocationDistance = 2000
    
    var venueString: String? = nil {
        didSet {
            loadVenues(string: venueString! , lat: self.currentLocation.latitude, long: self.currentLocation.longitude)
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
    
    private func setUpDelegates(){
        venueCollectionView.delegate = self
        venueCollectionView.dataSource = self
        searchVenue.delegate = self
        searchLocation.delegate = self
        locationManager.delegate = self
        searchVenue.searchTextField.textColor = .white
        searchLocation.searchTextField.textColor = .white
        
        
    }
    
    
    private func loadVenues(string: String, lat: Double, long: Double) {
        FSAPIClient.shared.getVenuesFrom(lat: lat, long: long, query: string) { (result) in
            switch result {
            case .success(let venueData):
                self.venues = venueData.response?.venues ?? []
                self.venueCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        setUpDelegates()
        locationAuthorization()
        mapView.userTrackingMode = .follow
        super.viewDidLoad()
    }
    
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCell", for: indexPath) as! VenueCollectionViewCell
        let currentVenue = venues[indexPath.row]
        cell.venueLabel.text = currentVenue.name
        cell.layer.cornerRadius = 6
        var photoURL = ""
//            FSAPIClient.shared.getPictureURL(venueID: currentVenue.id ) { (result) in
//                switch result {
//                case .success(let string):
//                    guard let url = string else { return }
//                    photoURL = url
//                    print(photoURL)
//                    ImageHelper.shared.fetchImage(urlString: url) { (result) in
//                                     switch result {
//                                     case .failure(let error):
//                                         print(error)
//                                         print(photoURL)
//                                     case .success(let pic):
//                                         cell.cellImage.image = pic
//                                     }
//                                 }
//                case .failure(let error):
//                    print(error)
//                    print("its me")
//                }
//            }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 181, height: 170 )
    }
}

extension MainViewController: UISearchBarDelegate {

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        switch searchBar.tag {
        case 0:
            guard searchBar.text != "" && searchBar.text != nil else { return }
            venueString = searchBar.text
            
            
        case 1:
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = searchLocation.text
            let activeSearch = MKLocalSearch(request: searchRequest)
            activeSearch.start { (response, error) in
                if response == nil {
                    print("no response from MKLocalSearch")
                } else {
                    print("getting here")
                    //get data from search
                    let lat = response?.boundingRegion.center.latitude
                    let long = response?.boundingRegion.center.longitude
                    let newAnnotation = MKPointAnnotation()
                    newAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                    let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
                    self.mapView.setRegion(coordinateRegion, animated: true)
                    self.currentLocation = .init(latitude: lat ?? 40.6782, longitude: long ?? -73.9442)
                }
            }
        default:
            print("tag not valid")
            
            
            
        }
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


