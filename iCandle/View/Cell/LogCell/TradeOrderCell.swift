//
//  TradeOrderCell.swift
//  iCandle
//
//  Created by Parves Kawser on 8/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class TradeOrderCell: UITableViewCell {
    
    @IBOutlet weak var scripeLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var atBeforeLabel: UILabel!
    @IBOutlet weak var atAfterLabel: UILabel!
    @IBOutlet weak var buyRemainingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
