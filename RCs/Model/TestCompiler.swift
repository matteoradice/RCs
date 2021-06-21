//
//  TestCompiler.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import Foundation

struct TestCompiler {
        
    init() {
        let projectA: Project = Project(clientName: "Client 1", projectTitle: "Project 1", clientPrice: 100, expensesRatio: 0.1, revenueCreditShare: 30, comments: "This is the first project for client 1", probability: 1)
        let projectB: Project = Project(clientName: "Client 1", projectTitle: "Project 2", clientPrice: 100, expensesRatio: 0.1, revenueCreditShare: 30, comments: "This is the second project for client 1", probability: 0.5)
        let projectC: Project = Project(clientName: "Client 2", projectTitle: "Project 1", clientPrice: 100, expensesRatio: 0.1, revenueCreditShare: 30, comments: "This is the first project for client 2", probability: 0)
        
// Activate if you want to add new projects
        CoreDataManager.shared.addProject(project: projectA)
        CoreDataManager.shared.addProject(project: projectB)
        CoreDataManager.shared.addProject(project: projectC)
        
    }
        
}
