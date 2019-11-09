//
//  DetailViewController.swift
//  foursquare
//
//  Created by Sam Roman on 11/7/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var venue: Venue?
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailName: UILabel!
    
    @IBOutlet weak var detailAddress: UILabel!
    
    @IBAction func backToSearchButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        detailName.text = venue?.name ?? ""
        detailAddress.text = venue?.location?.address ?? ""
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CreateViewController
        {
            let vc = segue.destination as? CreateViewController
            vc?.selectedVenue = venue
        }
    }


}
