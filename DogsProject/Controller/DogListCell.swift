//
//  DogListCell.swift
//  DogsProject
//
//  Created by chen levi on 17.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit

class DogListCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
