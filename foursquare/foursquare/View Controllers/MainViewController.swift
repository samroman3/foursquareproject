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
    
    var venues = [Venue]() {
        didSet{
            self.venueCollectionView.reloadData()
        }
    }
    
    private let locationManager = CLLocationManager()
  
    let searchRadius: CLLocationDistance = 2000
       
    var venueString: String? = nil {
        didSet{
            loadVenues(string: venueString ?? "coffee")
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
        locationManager.delegate = self
        searchVenue.searchTextField.textColor = .white
        searchLocation.searchTextField.textColor = .white
        
    }
    
    
    private func loadVenues(string: String){
        FSAPIClient.shared.getVenuesFrom(lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude, query: string) { (result) in
            switch result {
            case .success(let venueData):
                self.venues = venueData.response?.venues ?? []
                self.venueCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getVenueID(){
        
    }
    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        setUpDelegates()
        locationAuthorization()
        mapView.userTrackingMode = .follow
        loadVenues(string: "coffee")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }



}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return venues.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCell", for: indexPath) as! VenueCollectionViewCell
    let currentVenue = venues[indexPath.row]
    cell.venueLabel.text = currentVenue.name ?? ""
    cell.layer.cornerRadius = 6
    var photoURL = ""
//    FSAPIClient.shared.getPictureURL(venueID: currentVenue.id ?? "" ) { (result) in
//        switch result {
//        case .success(let string):
//            guard let url = string else { return }
//            photoURL = url
//            print(photoURL)
//        case .failure(let error):
//            print(error)
//            print("its me")
//        }
//    }
    
    return cell
}

    //TODO: Implement imagehelper to grab image
    /* ImageHelper.shared.fetchImage(urlString: url) { (result) in
                   switch result {
                   case .failure(let error):
                       print(error)
                       print(photoURL)
                   case .success(let pic):
                       cell.cellImage.image = pic
                   }
               }*/
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 181, height: 170 )
}
}

extension MainViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//      venueString = searchText
//    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        venueString = searchBar.text
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

