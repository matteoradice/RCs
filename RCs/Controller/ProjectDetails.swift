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
        if changes == true {
            let title: String = "Confirm saving"
            let message: String = "Do you want to save?"
            let saveConfirmation = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) {UIAlertAction in
                // Inserire azioni su pressione OK
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default) {UIAlertAction in
                // Inserire azioni su pressione CANCEL
            }
            saveConfirmation.addAction(okAction)
            saveConfirmation.addAction(cancelAction)
            self.present(saveConfirmation, animated: true, completion: nil)
        }
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
        if newProject?.clientName != clientTextField.text! {
            newProject?.clientName = clientTextField.text!
            changes = true
        }
        if newProject?.projectTitle != projectTitleTextField.text! {
            newProject?.projectTitle = projectTitleTextField.text!
            changes = true
        }
        if newProject?.clientPrice != Float(projectValueTextField.text!)! {
            newProject?.clientPrice = Float(projectValueTextField.text!)!
            changes = true
        }
        if newProject?.comments != commentsTextField.text! {
            newProject?.comments = commentsTextField.text!
            changes = true
        }
        if newProject?.expensesRatio != expensesSlider.value {
            newProject?.expensesRatio = expensesSlider.value
            changes = true
        }
        if newProject?.rcMultiplier != rcMultiplierSlider.value {
            newProject?.rcMultiplier = rcMultiplierSlider.value
            changes = true
        }
        if newProject?.revenueCreditShare != rcShareSlider.value {
            newProject?.revenueCreditShare = rcShareSlider.value
            changes = true
        }
        if newProject?.probability != probabilitySlider.value {
            newProject?.probability = probabilitySlider.value
            changes = true
        }
    }
    
}
