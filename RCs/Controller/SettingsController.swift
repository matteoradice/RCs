//
//  SettingsController.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import UIKit

class SettingsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        CoreDataManager.shared.deleteAllProjects()
    }
}
