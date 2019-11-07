//
//  ListViewController.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import CoreLocation


class ListViewController: UIViewController {
    
    
    
    var items = [Venue]() {
        didSet{
        }
    }
    
    @IBAction func backToSearchResults(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    

    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        let currentItem = items[indexPath.row]
        cell.listLabel.text = currentItem.name
        cell.listAddress.text = currentItem.location?.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
}
