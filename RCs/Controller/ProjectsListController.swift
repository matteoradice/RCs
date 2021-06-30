//
//  ProjectsListController.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import UIKit

class ProjectsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectTable: UITableView!
    
    var fullProjectsArray: [Project] = CoreDataManager.shared.loadAllProjects()
    
    struct ProjectsArrayForTable {
        var section:String!
        var rows:[String]!
    }
    var projectsArrayForTable: [ProjectsArrayForTable] = []
    
    // get rid of this line if you don't want to initialize the db
    // var testCompiler: TestCompiler = TestCompiler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectTable.delegate = self
        projectTable.dataSource = self
        projectsArrayForTable = createProjectListArrayForTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fullProjectsArray = CoreDataManager.shared.loadAllProjects()
        projectTable.reloadData()
    }
}

//MARK: - Create projectsArrayForTable

extension ProjectsListController {
    
    func createProjectListArrayForTable() -> [ProjectsArrayForTable] {
        var sectionsList:[String] = []
        var tempSectionsList:[String] = []
        var tempProjectsList:[String] = []
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
                        tempProjectsList.append(n.projectTitle)
                    }
                    tempProjectsList.sort()
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
        cell.textLabel?.text = projectsArrayForTable[indexPath.section].rows[indexPath.row]
        return cell
    }
    
}
