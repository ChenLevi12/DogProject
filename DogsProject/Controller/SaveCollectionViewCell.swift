//
//  SaveCollectionViewCell.swift
//  DogsProject
//
//  Created by chen levi on 18.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//

import UIKit

class SaveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var etitingImage: UIImageView!
    @IBOutlet weak var image: UIImageView!
    var isEditing = false{
        didSet{
            etitingImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool{
        didSet{
            etitingImage.image = isSelected ? #imageLiteral(resourceName: "icons8-ok") : #imageLiteral(resourceName: "icons8-circle")

        }
    }
}
