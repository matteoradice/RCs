//
//  ProjectsListController.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import UIKit

class ProjectsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectTable: UITableView!
    
    var splashForEmptyDBLabel: UILabel = UILabel()
    
    struct ProjectsArrayForTable {
        var section:String!
        var rows:[(UUID, String)]!
    }
    var projectsArrayForTable: [ProjectsArrayForTable] = []
    
    var idOfSelectedProject: UUID = UUID()
    var selectedProject: Project?
    
    let colors: [UIColor] = [.lightGray, .lightGray]
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashForEmptyDBLabel = UILabel(frame: CGRect(x: 5, y: 5, width: self.view.bounds.width - 10, height: self.view.bounds.height - 10))
        splashForEmptyDBLabel.backgroundColor = .white
        splashForEmptyDBLabel.textAlignment = .center
        splashForEmptyDBLabel.text = "Database is empty"
        view.addSubview(splashForEmptyDBLabel)
        
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
        if fullProjectsArray.count == 0 {
            manageEmptyArray(empty: true)
            return []
        }
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
            manageEmptyArray(empty: false)
            return project
        }
    }
    
    func manageEmptyArray(empty: Bool) {
        splashForEmptyDBLabel.isHidden = !empty
        print(splashForEmptyDBLabel.isHidden)
    }
}

    //MARK: - UITableView Delegate and Data Source methods
    extension ProjectsListController {
        
        // Number of sections
        func numberOfSections(in tableView: UITableView) -> Int {
            return projectsArrayForTable.count
        }
        
        // Number of rows in a section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return projectsArrayForTable[section].rows.count
        }
        
        // Row content
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
            let valuesForCell: [String] = populateCell(indexPath: indexPath)
            cell.projectTitleLabel.text = valuesForCell[0]
            cell.rcLabel.text = valuesForCell[1]
            cell.probabilityLabel.text = valuesForCell[2]
            cell.rcShareLabel.text = valuesForCell[3]
            if Float(valuesForCell[2]) == 1 { cell.probabilityIconImage.image = UIImage(named: "project_image") }
            else if Float(valuesForCell[2]) == 0 { cell.probabilityIconImage.image = UIImage(named: "lost_image")}
            else { cell.probabilityIconImage.image = UIImage(named: "lead_image") }
            return cell
        }
        
        // Height of the rows
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
        
        // Height of the header
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return headerHeight
        }
        
        // Personalized headers (color)
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let distanceHeaderTitleFromLead: CGFloat = 10
            let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: headerHeight))
            let title: UILabel = UILabel(frame: CGRect(x: distanceHeaderTitleFromLead, y: 0, width: view.bounds.width - distanceHeaderTitleFromLead, height: view.bounds.height))
            title.font = UIFont(name: "Helvetica Neue Bold", size: 12)
            if section % 2 == 0 { view.backgroundColor = colors[0] }
            else { view.backgroundColor = colors[1] }
            if projectsArrayForTable.count > 0 { title.text = projectsArrayForTable[section].section }
            else { title.text = "No entries yet" }
            view.addSubview(title)
            return view
        }
        
        // Delete rows routine
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                CoreDataManager.shared.deleteProject(uniqueId: projectsArrayForTable[indexPath.section].rows[indexPath.row].0)
                projectsArrayForTable[indexPath.section].rows.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if projectsArrayForTable[indexPath.section].rows.count == 0 {
                    projectsArrayForTable.remove(at: indexPath.section)
                    tableView.deleteSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .fade)
                }
            }
            projectsArrayForTable = createProjectListArrayForTable()
        }
        
        // Selection of a row and call segue
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let id = projectsArrayForTable[indexPath.section].rows[indexPath.row].0
            let selectedProjectDM = CoreDataManager.shared.loadItemsByAttributes(uniqueId: id)
            selectedProject = CoreDataManager.shared.convertProjectDMInProject(projectDM: selectedProjectDM)[0]
            performSegue(withIdentifier: "goToDetail", sender: self)
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
    }
    
    
    //MARK: - Populate customized cells
    
    extension ProjectsListController {
        func populateCell(indexPath: IndexPath) -> [String] {
            let uuid: UUID = projectsArrayForTable[indexPath.section].rows[indexPath.row].0
            let title: String = CoreDataManager.shared.loadItemsByAttributes(uniqueId: uuid)[0].projectTitle!
            let value: String = String(format: "%.1f", CoreDataManager.shared.loadItemsByAttributes(uniqueId: uuid)[0].clientPrice)
            let probability: String = String(format: "%.1f", CoreDataManager.shared.loadItemsByAttributes(uniqueId: uuid)[0].probability)
            let rcShare: String = String(format: "%.1f", CoreDataManager.shared.loadItemsByAttributes(uniqueId: uuid)[0].revenueCreditShare)
            
            return [title, value, probability, rcShare]
        }
    }
