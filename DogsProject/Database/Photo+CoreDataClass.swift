//
//  Photo+CoreDataClass.swift
//  DogsProject
//
//  Created by chen levi on 18.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
    convenience init(pic: UIImage){
        let context = DBManager.shared.context
        let desc = NSEntityDescription.entity(forEntityName: "Photo", in: context)!
        self.init(entity: desc, insertInto: context)
        guard let picData = UIImageJPEGRepresentation(pic, 1) as NSData? else{return}
        self.pic = picData
    }

}
