//
//  ProjectCell.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var semaphoreImage: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var modifyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
