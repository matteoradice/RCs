//
//  AddNewProjectViewController.swift
//  RCs
//
//  Created by Matteo Radice on 22/06/21.
//

import UIKit

class AddNewProjectViewController: UIViewController, UITextFieldDelegate {
    
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
        
        clientTextField.isHighlighted = true
        
        clientTextField.delegate = self
        titleTextField.delegate = self
        valueTextField.delegate = self
        commentsTextField.delegate = self
        
    }
    
    func initializeView() {
        var slider: UISlider = UISlider()
        var label: UILabel = UILabel()
        for i in slidersAndLabels {
            slider = i.key
            label = i.value
            if slider == expensesSlider { slider.value = 10 }
            else if slider == rcShareSlider { slider.value = 50 }
            else if slider == probabilitySlider { slider.value = 50 }
            else { slider.value = 175 }
            label.text = String(format: "%.f", slider.value)
            if label == expensesLabel || label == probabilityLabel {
                label.text = label.text! + " %"
            }
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
        
        let interval = 1
        let value = Int(sender.value / Float(interval)) * interval
        sender.value = Float(value)
        
        receiver.text = String(format: "%.f", sender.value)
        if receiver == expensesLabel || receiver == probabilityLabel {
            receiver.text = receiver.text! + " %"
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let clientName: String = clientTextField.text ?? ""
        let projectTitle: String = titleTextField.text ?? ""
        let price: String = valueTextField.text ?? "0"
        
        if clientName != "" && projectTitle != "" && price != "" {
            
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
}

//MARK: - TextField delegates

extension AddNewProjectViewController {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" { return true }
        else { return false }
    }
    
}
