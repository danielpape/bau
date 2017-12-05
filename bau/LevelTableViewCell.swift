//
//  LevelTableViewCell.swift
//  bau
//
//  Created by Daniel Pape on 05/12/2017.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {

    @IBOutlet weak var levelNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
