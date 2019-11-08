//
//  BookmarksViewController.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    
    var bookmarks = [Bookmark](){
        didSet{
            
        }
    }
    

    @IBOutlet weak var bookmarkCV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
