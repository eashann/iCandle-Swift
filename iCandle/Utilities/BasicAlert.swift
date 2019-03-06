//
//  File.swift
//  Preperp
//
//  Created by Parves Kawser on 4/10/18.
//  Copyright © 2018 Preperp. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
