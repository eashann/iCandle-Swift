//
//  AnnouncementCell.swift
//  iCandle
//
//  Created by Eashan on 3/11/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class AnnouncementCell: UITableViewCell {
    
    @IBOutlet weak var scripCompanyLabel: UILabel!
    @IBOutlet weak var annoucementDate: UILabel!
    @IBOutlet weak var fyYELabel: UILabel!
    @IBOutlet weak var epsLabel: UILabel!
    @IBOutlet weak var blockStartEndDate: UILabel!
    @IBOutlet weak var plBeforeTaxLabel: UILabel!
    @IBOutlet weak var plAfterTaxLabel: UILabel!
    @IBOutlet weak var agmDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
