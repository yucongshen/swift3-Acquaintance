//
//  PersonMO+CoreDataProperties.swift
//  Acquaintance
//
//  Created by MacBook Pro  on 2016/11/29.
//  Copyright © 2016年 yucong shen. All rights reserved.
//

import Foundation
import CoreData


extension PersonMO {

    // MARK: Core Data Paths
    static let ApplicationSupportDirectory = FileManager().urls(for: .applicationSupportDirectory,
                                                                in: .userDomainMask).first!
    static let StoreURL = ApplicationSupportDirectory.appendingPathComponent("Acquaintance.sqlite")
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonMO> {
        return NSFetchRequest<PersonMO>(entityName: "PersonMO");
    }
    
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var category: String?

}
