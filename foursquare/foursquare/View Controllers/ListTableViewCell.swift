//
//  TableViewCell.swift
//  foursquare
//
//  Created by Sam Roman on 11/7/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listImage: UIImageView!
    
    
    @IBOutlet weak var listLabel: UILabel!
    
    @IBOutlet weak var listAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
