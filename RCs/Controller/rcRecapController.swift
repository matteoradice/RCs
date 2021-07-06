//
//  rcRecapController.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import UIKit

class rcRecapController: UIViewController {
    
    @IBOutlet weak var weightedRcLabel: UILabel!
    @IBOutlet weak var soldRcLabel: UILabel!
    
    let rcManager = RcManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightedRcLabel.text = rcManager.calculateWeightedRcs()
        soldRcLabel.text = rcManager.calculateSoldRcs()
    }
    
}
