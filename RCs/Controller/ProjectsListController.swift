//
//  ProjectsListController.swift
//  RCs
//
//  Created by Matteo Radice on 21/06/21.
//

import UIKit

class ProjectsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectTable: UITableView!
    
    //  COMPILING INITIAL DATASET
    //    var testCompiler: TestCompiler = TestCompiler()
    
    let fullProjectsArray: [Project] = CoreDataManager.shared.loadAllProjects()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Preparation of the table (projectTable)
        let nib = UINib(nibName: "ProjectListCell", bundle: .none)
        projectTable.register(nib, forCellReuseIdentifier: "ProjectListCell")
        projectTable.delegate = self
        projectTable.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullProjectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath) as! ProjectListCell
        
        if fullProjectsArray.count != 0 {
            
            let project = fullProjectsArray[indexPath.row]
            
            cell.clientLabel.text = project.clientName
            cell.titleLabel.text = project.projectTitle
            cell.colorLabel.text = ""
            
            if project.probability == 1 { cell.colorLabel.backgroundColor = .systemGreen }
            
            else if project.probability > 0 && project.probability < 1 { cell.colorLabel.backgroundColor = .systemOrange }
            
            else { cell.colorLabel.backgroundColor = .systemRed }
            
            return cell }
        else { return cell }
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
