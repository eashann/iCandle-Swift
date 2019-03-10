//
//  CollateralsCell.swift
//  iCandle
//
//  Created by Eashan on 3/10/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class CollateralsCell: UITableViewCell {
    
    @IBOutlet weak var scripLabel: UILabel!
    @IBOutlet weak var netQTLabel: UILabel!
    @IBOutlet weak var marketValueLabel: UILabel!
    @IBOutlet weak var boughtQTLabel: UILabel!
    @IBOutlet weak var pendingBuyLabel: UILabel!
    @IBOutlet weak var settledQTLabel: UILabel!
    @IBOutlet weak var marketRateLabel: UILabel!
    @IBOutlet weak var soldQTLabel: UILabel!
    @IBOutlet weak var pendingCellLabel: UILabel!
    @IBOutlet weak var unsettledLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
