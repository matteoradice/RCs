//
//  ProjectCell.swift
//  RCs
//
//  Created by Matteo Radice on 06/07/21.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    
    @IBOutlet weak var probabilityIconImage: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var rcLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var rcShareLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
