//
//  ProjectDM+CoreDataProperties.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//
//

import Foundation
import CoreData


extension ProjectDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectDM> {
        return NSFetchRequest<ProjectDM>(entityName: "ProjectDM")
    }

    @NSManaged public var clientName: String?
    @NSManaged public var clientPrice: Float
    @NSManaged public var comments: String?
    @NSManaged public var expensesRatio: Float
    @NSManaged public var probability: Float
    @NSManaged public var projectTitle: String?
    @NSManaged public var rcMultiplier: Float
    @NSManaged public var revenueCreditShare: Float

}

extension ProjectDM : Identifiable {

}
