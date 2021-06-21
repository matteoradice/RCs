//
//  CoreDataManager.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private var context: NSManagedObjectContext
    private init() {
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
    }
    
    //  OK TESTED
    func loadAllProjects() -> [Project] {
        let request:NSFetchRequest<ProjectDM> = NSFetchRequest(entityName: "ProjectDM")
        request.returnsObjectsAsFaults = false
        let retrievedData = self.loadFromFetchRequest(request: request)
        let projects = convertProjectDMInProject(projectDM: retrievedData)
        return projects
    }
    
    //  OK TESTED
    func addProject(project: Project) {
        let item = NSEntityDescription.entity(forEntityName: "ProjectDM", in: self.context)
        let newItem = ProjectDM(entity: item!, insertInto: self.context)
        newItem.clientName = project.clientName
        newItem.clientPrice = project.clientPrice
        newItem.comments = project.comments
        newItem.expensesRatio = project.expensesRatio
        newItem.probability = project.probability
        newItem.projectTitle = project.projectTitle
        newItem.rcMultiplier = project.rcMultiplier
        newItem.revenueCreditShare = project.revenueCreditShare
        do { try self.context.save() }
        catch let error { print(error) }
    }
    
    
    //  OK TESTED
    func deleteProject(project: Project) {
        let item = self.loadItemsByAttributes(project: project)[0]
        self.context.delete(item)
        do {
            try self.context.save()
        } catch let error {
            print(error)
        }
    }
    
    //  OK TESTED
    func deleteAllProjects() {
        let request:NSFetchRequest<ProjectDM> = NSFetchRequest(entityName: "ProjectDM")
        request.returnsObjectsAsFaults = false
        let retrievedData = self.loadFromFetchRequest(request: request)
        for i in retrievedData {
            self.context.delete(i)
            do {
                try self.context.save()
            } catch let error {
                print(error)
            }
        }
    }
}
    
        
  
//MARK: - Private methods
extension CoreDataManager {
    
    //  OK TESTED
    private func loadFromFetchRequest(request: NSFetchRequest<ProjectDM>) -> [ProjectDM] {
        var array = [ProjectDM]()
        do {
            array = try self.context.fetch(request)
            guard array.count > 0 else {
                print("Database is empty")
                return []
            }
            return array
        }
        catch let error {
            print(error)
        }
        return []
    }
    
    //  OK TESTED
    private func convertProjectDMInProject(projectDM: [ProjectDM]) -> [Project] {
        var projects: [Project] = []
        for i in projectDM {
            let project: Project = Project(clientName: i.clientName!,
                                           projectTitle: i.projectTitle!,
                                           clientPrice: i.clientPrice,
                                           expensesRatio: i.expensesRatio,
                                           revenueCreditShare: i.revenueCreditShare,
                                           comments: i.comments!,
                                           probability: i.probability,
                                           rcMultiplier: i.rcMultiplier)
            projects.append(project)
        }
        return projects
    }
    
    
    // OK TESTED
    private func convertProjectInProjectDM(project: [Project]) -> [ProjectDM] {
        var projectsDM: [ProjectDM] = []
        let projectDM: ProjectDM = ProjectDM(context: context)
        for i in project {
            projectDM.clientName = i.clientName
            projectDM.clientPrice = i.clientPrice
            projectDM.comments = i.comments
            projectDM.expensesRatio = i.expensesRatio
            projectDM.probability = i.probability
            projectDM.projectTitle = i.projectTitle
            projectDM.rcMultiplier = i.rcMultiplier
            projectDM.revenueCreditShare = i.revenueCreditShare
            projectsDM.append(projectDM)
        }
        return projectsDM
    }
    
    //  OK TESTED
    private func loadItemsByAttributes(project: Project) -> [ProjectDM] {
        let request: NSFetchRequest<ProjectDM> = NSFetchRequest(entityName: "ProjectDM")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "clientName = %@ AND projectTitle = %@ AND clientPrice = %f AND expensesRatio = %f AND revenueCreditShare = %f AND comments = %@ AND probability = %f AND rcMultiplier = %f", project.clientName, project.projectTitle, project.clientPrice, project.expensesRatio, project.revenueCreditShare, project.comments, project.probability, project.rcMultiplier)
        request.predicate = predicate
        let items = self.loadFromFetchRequest(request: request)
        return items
    }
}

    


