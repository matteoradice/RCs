//
//  Project.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import Foundation
import UIKit

class Project {
    
    // Attributes
    var clientName: String
    var projectTitle: String
    var clientPrice: Float
    var expensesRatio: Float
    var revenueCreditShare: Float
    var comments: String
    var probability: Float
    var rcMultiplier: Float
    var uniqueId: UUID
    
    // Initialization of the attributes
    init(clientName: String, projectTitle: String, clientPrice: Float, expensesRatio: Float, revenueCreditShare: Float, comments: String, probability: Float, rcMultiplier: Float = 175, uniqueId: UUID = UUID()) {
        self.clientName = clientName
        self.projectTitle = projectTitle
        self.clientPrice = clientPrice
        self.expensesRatio = expensesRatio
        self.revenueCreditShare = revenueCreditShare
        self.comments = comments
        self.probability = probability
        self.rcMultiplier = rcMultiplier
        self.uniqueId = uniqueId
    }
    
}
