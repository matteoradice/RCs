//
//  AddNewProjectViewController.swift
//  RCs
//
//  Created by Matteo Radice on 22/06/21.
//

import UIKit

class AddNewProjectViewController: UIViewController {

    @IBOutlet weak var clientTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var expensesSlider: UISlider!
    @IBOutlet weak var rcShareSlider: UISlider!
    @IBOutlet weak var probabilitySlider: UISlider!
    @IBOutlet weak var rcMultiplierSlider: UISlider!
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var rcShareLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var rcMultiplierLabel: UILabel!
    
    var slidersAndLabels: [UISlider : UILabel] = [:]
    var textFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slidersAndLabels = [expensesSlider : expensesLabel, rcShareSlider : rcShareLabel, probabilitySlider : probabilityLabel, rcMultiplierSlider : rcMultiplierLabel]
        textFields = [clientTextField, titleTextField, valueTextField, commentsTextField]
         initializeView()
        
    }
    
    func initializeView() {
        var slider: UISlider = UISlider()
        var label: UILabel = UILabel()
        for i in slidersAndLabels {
            slider = i.key
            label = i.value
            label.text = String(format: "%.1f", slider.value)
        }
        for i in textFields {
            i.text = ""
        }
    }
    
    @IBAction func movedSlider(_ sender: UISlider) {
        var receiver: UILabel = UILabel()
        for i in slidersAndLabels {
            if i.key == sender { receiver = i.value }
        }
        receiver.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let clientName: String = clientTextField.text ?? ""
        let projectTitle: String = titleTextField.text ?? ""
        let price: String = valueTextField.text ?? "0"
        let clientPrice: Float = Float(price) ?? 0
        let expensesRatio: Float = expensesSlider.value
        let revenueCreditShare: Float = rcShareSlider.value
        let comments: String = commentsTextField.text ?? ""
        let probability: Float = probabilitySlider.value
        let rcMultiplier: Float = rcMultiplierSlider.value
        let project: Project = Project(clientName: clientName, projectTitle: projectTitle, clientPrice: clientPrice, expensesRatio: expensesRatio, revenueCreditShare: revenueCreditShare, comments: comments, probability: probability, rcMultiplier: rcMultiplier)
        
        let title: String = "Confirm saving"
        let message: String = "Do you want to save?"
        
        let saveConfirmation = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) {UIAlertAction in         CoreDataManager.shared.addProject(project: project)
            self.initializeView() }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default) {UIAlertAction in saveConfirmation.dismiss(animated: true) }
        
        saveConfirmation.addAction(okAction)
        saveConfirmation.addAction(cancelAction)
        
        self.present(saveConfirmation, animated: true, completion: nil)
        
    }
}
