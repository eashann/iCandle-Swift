//
//  MoversVC.swift
//  iCandle
//
//  Created by Eashan on 2/28/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class MoversVC: UIViewController {
    
    @IBOutlet weak var segmentedView: UISegmentedControl!
    
    @IBOutlet weak var gainerView: UIView!
    @IBOutlet weak var leadersView: UIView!
    @IBOutlet weak var looserView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // USER INTERFACE
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBAction func segmentedControllPressed(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0) {
            leadersView.alpha = 1
            gainerView.alpha  = 0
            looserView.alpha  = 0
        } else if (sender.selectedSegmentIndex == 1) {
            gainerView.alpha  = 1
            looserView.alpha  = 0
            leadersView.alpha = 0
        } else if (sender.selectedSegmentIndex == 2) {
            looserView.alpha  = 1
            gainerView.alpha  = 0
            leadersView.alpha = 0
        }
    }
}
