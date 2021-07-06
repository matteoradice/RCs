//
//  ProjectCell.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var semaphoreView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var disclosureView: UIView!
    
    @IBOutlet weak var semaphoreImage: UIImageView!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var disclosureImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
