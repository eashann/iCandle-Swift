//
//  SummaryCell.swift
//  iCandle
//
//  Created by Eashan on 3/10/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class SummaryCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
