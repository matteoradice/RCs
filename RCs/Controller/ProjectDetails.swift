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
    
    
    var uniqueId: UUID?
    var project: [ProjectDM]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        project = CoreDataManager.shared.loadItemsByAttributes(uniqueId: uniqueId!)
        print(project![0].clientName)
        compileFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
    }
    
}

//MARK: - Initialize fields on the UIViewController

extension ProjectDetails {
    
    func compileFields() {
        clientTextField.text = project![0].clientName
        projectTitleTextField.text = project![0].projectTitle
        projectValueTextField.text = String(project![0].clientPrice)
        commentsTextField.text = project![0].comments
        
        expensesSlider.value = project![0].expensesRatio
        rcShareSlider.value = project![0].revenueCreditShare
        probabilitySlider.value = project![0].probability
        rcMultiplierSlider.value = project![0].rcMultiplier
        
        expensesLabel.text = String(project![0].expensesRatio)
        rcShareLabel.text = String(project![0].revenueCreditShare)
        probabilityLabel.text = String(project![0].probability)
        rcMultiplierLabel.text = String(project![0].rcMultiplier)
 
    }
    
}
