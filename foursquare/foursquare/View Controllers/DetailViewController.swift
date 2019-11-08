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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
