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
    var weightedRc: String = ""
    var soldRc: String = ""
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightedRc = rcManager.calculateWeightedRcs()
        soldRc = rcManager.calculateSoldRcs()
        
        weightedRcLabel.text = weightedRc
        soldRcLabel.text = soldRc
    }
    
}
