//
//  ProjectDetails.swift
//  RCs
//
//  Created by Matteo Radice on 30/06/21.
//

import UIKit

class ProjectDetails: UIViewController {
    
    @IBOutlet weak var clientTextField: UITextField!
    @IBOutlet weak var projectTitleTextField: UITextField!
    @IBOutlet weak var projectValueTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var rcShareLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var rcMultiplierLabel: UILabel!
    @IBOutlet weak var expensesSlider: UISlider!
    @IBOutlet weak var rcShareSlider: UISlider!
    @IBOutlet weak var probabilitySlider: UISlider!
    @IBOutlet weak var rcMultiplierSlider: UISlider!
    
    var project: Project?
    var newProject: Project?
    var changes: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compileFields()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        acquireChanges()
        saveNewItem()
    }
}

//MARK: - Initialize fields on the UIViewController

extension ProjectDetails {
    func compileFields() {
        clientTextField.text = project!.clientName
        projectTitleTextField.text = project!.projectTitle
        projectValueTextField.text = String(project!.clientPrice)
        commentsTextField.text = project!.comments
        expensesSlider.value = project!.expensesRatio
        rcShareSlider.value = project!.revenueCreditShare
        probabilitySlider.value = project!.probability
        rcMultiplierSlider.value = project!.rcMultiplier
        expensesLabel.text = String(project!.expensesRatio)
        rcShareLabel.text = String(project!.revenueCreditShare)
        probabilityLabel.text = String(project!.probability)
        rcMultiplierLabel.text = String(project!.rcMultiplier)
    }
}

//MARK: - Import all the changes made in the fields for saving

extension ProjectDetails {
    
    func acquireChanges() {
        let clientName = clientTextField.text!
        let projectTitle = projectTitleTextField.text!
        let clientPrice = Float(projectValueTextField.text!)!
        let comments = commentsTextField.text!
        let expensesRatio = expensesSlider.value
        let rcMultiplier = rcMultiplierSlider.value
        let revenueCreditShare = rcShareSlider.value
        let probability = probabilitySlider.value
        
        newProject = Project(clientName: clientName, projectTitle: projectTitle, clientPrice: clientPrice, expensesRatio: expensesRatio, revenueCreditShare: revenueCreditShare, comments: comments, probability: probability, rcMultiplier: rcMultiplier)
        
        if newProject?.clientName == project?.clientName && newProject?.clientPrice == project?.clientPrice && newProject?.comments == project?.comments && newProject?.probability == project?.probability && newProject?.rcMultiplier == project?.rcMultiplier && newProject?.projectTitle == project?.projectTitle && newProject?.revenueCreditShare == project?.revenueCreditShare {
            changes = false
        } else { changes = true }
    }
}


extension ProjectDetails {
    func saveNewItem() {
            let title: String = "Confirm saving"
            let message: String = "Do you want to save?"
            let saveConfirmation = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) {UIAlertAction in
                CoreDataManager.shared.addProject(project: self.newProject!)
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { UIAlertAction in saveConfirmation.dismiss(animated: true) }
            saveConfirmation.addAction(okAction)
            saveConfirmation.addAction(cancelAction)
            self.present(saveConfirmation, animated: true, completion: nil)
            CoreDataManager.shared.deleteProject(uniqueId: project!.uniqueId)
    }
}
