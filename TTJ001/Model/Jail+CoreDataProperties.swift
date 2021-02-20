//
//  Jail+CoreDataProperties.swift
//  TTJ001
//
//  Created by Rodney Hermes on 2/18/21.
//
//

import Foundation
import CoreData


extension Jail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jail> {
        return NSFetchRequest<Jail>(entityName: "Jail")
    }

    @NSManaged public var county: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var material: String?
    @NSManaged public var jailNum: Int64
    @NSManaged public var photo1: String?
    @NSManaged public var photo2: String?
    @NSManaged public var photo3: String?
    @NSManaged public var town: String?
    @NSManaged public var year: Date?

}

extension Jail : Identifiable {

}
