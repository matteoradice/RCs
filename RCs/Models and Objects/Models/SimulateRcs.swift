//
//  SimulateRcs.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import Foundation
import UIKit

enum ProbabilityOptions: String {
    case weighted = "Calculate with probabilities"
    case confirmed = "Calculate only sold projects"
    case force = "Calculate all pipeline as sold"
}

struct SimulateRcs {
        
    func calculateWeightedRcs(probabilityOptions: ProbabilityOptions, allProjects: [Project]) -> Float {
        //  attributes
        var rcs: Float = 0
        var tempRcs: Float = 0
        
        for i in allProjects {
            //  change the value of probability based on the desired kind of weight
            var probability: Float {
                switch probabilityOptions {
                case .confirmed:
                    return i.probability < 1 ? 0 : 1
                case .weighted:
                    return i.probability
                case .force:
                return 1
                }
            }
            //  calculation of RCs
            tempRcs = (i.clientPrice / (1 + i.expensesRatio) * i.rcMultiplier * probability) / i.rcMultiplier * i.revenueCreditShare
            rcs += tempRcs
        }
        return rcs
    }
    
    func convertInEur(rcs: Float, fx: Float) -> Float {
        return rcs * fx
    }
}
