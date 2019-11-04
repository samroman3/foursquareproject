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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

