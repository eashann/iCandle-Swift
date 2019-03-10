//
//  KMI30Cell.swift
//  iCandle
//
//  Created by Parves Kawser on 7/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class KMI30Cell: UITableViewCell {
    
    @IBOutlet weak var scripLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var upperCapLabel: UILabel!
    @IBOutlet weak var lowerCapLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
