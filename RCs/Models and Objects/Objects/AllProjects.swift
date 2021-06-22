//
//  AllProjects.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import Foundation
import UIKit

class AllProjects {
    
    var projectsArray: [Project] {
        return CoreDataManager.shared.loadAllProjects()
    }

}
