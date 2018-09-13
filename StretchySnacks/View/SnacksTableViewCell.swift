//
//  SnacksTableViewCell.swift
//  StretchySnacks
//
//  Created by Jamie on 2018-09-13.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class SnacksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var snackUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
