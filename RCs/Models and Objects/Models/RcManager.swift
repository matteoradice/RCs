//
//  RcManager.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import Foundation

struct RcManager {
    
    let allProjects: [Project] = CoreDataManager.shared.loadAllProjects()
    
    func calculateWeightedRcs() -> String {
        var rcs: Float = 0
        for i in allProjects {
            rcs += i.probability * i.revenueCreditShare * (i.clientPrice / (1 + i.expensesRatio))
        }
        return String(rcs)
    }
    
    func calculateSoldRcs() -> String {
        var rcs: Float = 0
        for i in allProjects {
            if i.probability == 1 {
                rcs += i.probability * i.revenueCreditShare * (i.clientPrice / (1 + i.expensesRatio))
            }
        }
        return String(rcs)
    }
    
}
