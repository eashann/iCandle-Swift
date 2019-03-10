//
//  WorkingOrderCell.swift
//  iCandle
//
//  Created by Parves Kawser on 8/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class WorkingOrderCell: UITableViewCell {
    
    
    @IBOutlet weak var scripLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var buyStatusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var atBefore: UILabel!
    @IBOutlet weak var atAfter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
