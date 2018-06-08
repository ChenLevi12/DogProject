//
//  GameCollectionViewCell.swift
//  DogsProject
//
//  Created by chen levi on 22.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var circleImage: UIImageView!
    override var isSelected: Bool{
        didSet{
            circleImage.image = isSelected ? #imageLiteral(resourceName: "icons8-ok") : #imageLiteral(resourceName: "icons8-circle")
        }
    }
}
