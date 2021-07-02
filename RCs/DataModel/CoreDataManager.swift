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
        newItem.uniqueId = project.uniqueId
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
    func deleteProject(uniqueId: UUID) {
        let item = self.loadItemsByAttributes(uniqueId: uniqueId)[0]
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
    func convertProjectDMInProject(projectDM: [ProjectDM]) -> [Project] {
        var projects: [Project] = []
        for i in projectDM {
            let project: Project = Project(clientName: i.clientName!,
                                           projectTitle: i.projectTitle!,
                                           clientPrice: i.clientPrice,
                                           expensesRatio: i.expensesRatio,
                                           revenueCreditShare: i.revenueCreditShare,
                                           comments: i.comments!,
                                           probability: i.probability,
                                           rcMultiplier: i.rcMultiplier,
                                           uniqueId: i.uniqueId!)
            projects.append(project)
        }
        return projects
    }
    
    //  OK TESTED
    func loadItemsByAttributes(uniqueId: UUID) -> [ProjectDM] {
        let request: NSFetchRequest<ProjectDM> = NSFetchRequest(entityName: "ProjectDM")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "uniqueId = %@", uniqueId as CVarArg)
        request.predicate = predicate
        let items = self.loadFromFetchRequest(request: request)
        return items
    }
}

    


