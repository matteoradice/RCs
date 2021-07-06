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
    var selectedProject: Project?
    
    let colors: [UIColor] = [.systemGray, .systemGray]
    let headerHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTable.delegate = self
        projectTable.dataSource = self
        let nib: UINib = UINib(nibName: "ProjectCell", bundle: nil)
        projectTable.register(nib, forCellReuseIdentifier: "ProjectCell")
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
        if projectsArrayForTable.count > 0 { return projectsArrayForTable.count }
        else { return 1 }
    }
    
    // Number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if projectsArrayForTable.count > 0 { return projectsArrayForTable[section].rows.count }
        else { return 1 }
    }
    
    // Row content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        if projectsArrayForTable.count > 0 {
            cell.projectTitleLabel.text = projectsArrayForTable[indexPath.section].rows[indexPath.row].1
            let probability: Float = CoreDataManager.shared.loadItemsByAttributes(uniqueId: projectsArrayForTable[indexPath.section].rows[indexPath.row].0)[0].probability
            if probability == 1 { cell.semaphoreImage.backgroundColor = .systemGreen }
            else if probability == 0 { cell.semaphoreImage.backgroundColor = .systemRed}
            else { cell.semaphoreImage.backgroundColor = .systemYellow }
        }
        else { cell.projectTitleLabel.text = "No entries yet"}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let distanceHeaderTitleFromLead: CGFloat = 10
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: headerHeight))
        let title: UILabel = UILabel(frame: CGRect(x: distanceHeaderTitleFromLead, y: 0, width: view.bounds.width - distanceHeaderTitleFromLead, height: view.bounds.height))
        if section % 2 == 0 { view.backgroundColor = colors[0] }
        else { view.backgroundColor = colors[1] }
        if projectsArrayForTable.count > 0 { title.text = projectsArrayForTable[section].section }
        else { title.text = "No entries yet" }
        view.addSubview(title)
        return view
    }
}

//MARK: - Manage the transition across different UIViewControllers

extension ProjectsListController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let viewController = segue.destination as? ProjectDetails {
                viewController.project = selectedProject!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = projectsArrayForTable[indexPath.section].rows[indexPath.row].0
        let selectedProjectDM = CoreDataManager.shared.loadItemsByAttributes(uniqueId: id)
        selectedProject = CoreDataManager.shared.convertProjectDMInProject(projectDM: selectedProjectDM)[0]
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
}
