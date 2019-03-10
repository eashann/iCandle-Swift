//
//  KomVC.swift
//  iCandle
//
//  Created by Eashan on 2/28/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class LogsVC: UIViewController {
    
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var workingOrderView: UIView!
    @IBOutlet weak var tradeOrderView: UIView!
    @IBOutlet weak var orderActivityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workingOrderView.alpha  = 1
        tradeOrderView.alpha    = 0
        orderActivityView.alpha = 0
    }
    
    // USER INTERFACE
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0) {
            workingOrderView.alpha  = 1
            tradeOrderView.alpha    = 0
            orderActivityView.alpha = 0
        } else if (sender.selectedSegmentIndex == 1) {
            tradeOrderView.alpha    = 1
            workingOrderView.alpha  = 0
            orderActivityView.alpha = 0
        } else if (sender.selectedSegmentIndex == 2) {
            orderActivityView.alpha = 1
            workingOrderView.alpha  = 0
            tradeOrderView.alpha    = 0
        } else {
            workingOrderView.alpha  = 1
            tradeOrderView.alpha    = 0
            orderActivityView.alpha = 0
        }
    }
}
