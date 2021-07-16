//
//  RcManager.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import Foundation

struct RcManager {
    
    func calculateWeightedRcs() -> String {
        let allProjects: [Project] = CoreDataManager.shared.loadAllProjects()
        print("Weighted \(allProjects)")
        var rcs: Float = 0
        for i in allProjects {
            let valueClean: Float = i.clientPrice / (1 + (i.expensesRatio / 100))
            let unitRc: Float = valueClean / 100
            rcs += unitRc * (i.probability / 100) * i.revenueCreditShare
        }
        return String(format: "%.1f", rcs)
    }
    
    func calculateSoldRcs() -> String {
        let allProjects: [Project] = CoreDataManager.shared.loadAllProjects()
        print("Sold \(allProjects)")
        var rcs: Float = 0
        for i in allProjects {
            if i.probability == 1 {
                let valueClean: Float = i.clientPrice / (1 + (i.expensesRatio / 100))
                let unitRc: Float = valueClean / 100
                rcs += unitRc * (i.probability / 100) * i.revenueCreditShare
            }
        }
        return String(format: "%.1f", rcs)
    }
    
}
