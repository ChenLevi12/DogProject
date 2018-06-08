//
//  Photo+CoreDataProperties.swift
//  DogsProject
//
//  Created by chen levi on 18.12.2017.
//  Copyright © 2017 chen levi. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var pic: NSData

}
