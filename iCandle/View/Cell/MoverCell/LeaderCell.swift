//
//  LeaderCell.swift
//  iCandle
//
//  Created by Eashan on 3/9/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class LeaderCell: UITableViewCell {
    
    @IBOutlet weak var scripLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var upperCapLabel: UILabel!
    @IBOutlet weak var lowerCapLabel: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
