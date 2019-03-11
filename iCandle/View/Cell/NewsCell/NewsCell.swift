//
//  NewsCell.swift
//  iCandle
//
//  Created by Eashan on 3/11/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var scripCompanyLabel: UILabel!
    @IBOutlet weak var annoucementDate: UILabel!
    @IBOutlet weak var allTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
