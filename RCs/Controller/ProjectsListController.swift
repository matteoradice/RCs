//
//  ProjectsListController.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import UIKit

class ProjectsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectTable: UITableView!
    
    struct ProjectsArrayForTable {
        var section:String!
        var rows:[(UUID, String)]!
    }
    var projectsArrayForTable: [ProjectsArrayForTable] = []
    
    var idOfSelectedProject: UUID = UUID()
    
    // get rid of this line if you don't want to initialize the db
    // var testCompiler: TestCompiler = TestCompiler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectTable.delegate = self
        projectTable.dataSource = self
        projectsArrayForTable = createProjectListArrayForTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        projectsArrayForTable = createProjectListArrayForTable()
        projectTable.reloadData()
    }
    
}

//MARK: - Initialize data structure for this UIViewController

extension ProjectsListController {
    
    func createProjectListArrayForTable() -> [ProjectsArrayForTable] {
        let fullProjectsArray: [Project] = CoreDataManager.shared.loadAllProjects()
        var sectionsList:[String] = []
        var tempSectionsList:[String] = []
        var tempProjectsList:[(UUID, String)] = []
        var project:[ProjectsArrayForTable] = []
        
        if fullProjectsArray.count == 0 { return [] }
        
        else {
            
            for i in fullProjectsArray {
                sectionsList.append(i.clientName)
                sectionsList.sort()
            }
            
            for i in 0...sectionsList.count - 1 {
                if i == 0 { tempSectionsList.append(sectionsList[i]) }
                else {
                    if sectionsList[i] == tempSectionsList.last { continue }
                    else { tempSectionsList.append(sectionsList[i]) }
                }
            }
            
            sectionsList = tempSectionsList
            
            for i in sectionsList {
                for n in fullProjectsArray {
                    if n.clientName == i {
                        tempProjectsList.append((n.uniqueId, n.projectTitle))
                    }
                }
                project.append(ProjectsArrayForTable(section: i, rows: tempProjectsList))
                tempProjectsList = []
                
            }
            return project
        }
    }
}

//MARK: - UITableView Delegate and Data Source methods
extension ProjectsListController {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return projectsArrayForTable.count
    }
    
    // Title for the section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return projectsArrayForTable[section].section
    }
    
    
    // Number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsArrayForTable[section].rows.count
    }
    
    // Row content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath)
        cell.textLabel?.text = projectsArrayForTable[indexPath.section].rows[indexPath.row].1
        return cell
    }
    
}

//MARK: - Manage the transition across different UIViewControllers

extension ProjectsListController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            print("RUN")
            if let viewController = segue.destination as? ProjectDetails {
                viewController.uniqueId = idOfSelectedProject
            }
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        idOfSelectedProject = projectsArrayForTable[indexPath.section].rows[indexPath.row].0
    }
    
}
