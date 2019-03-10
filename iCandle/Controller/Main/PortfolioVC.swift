//
//  DummyVC.swift
//  iCandle
//
//  Created by Eashan on 2/28/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class PortfolioVC: UIViewController {
    
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var holdingView: UIView!
    @IBOutlet weak var collateralsView: UIView!
    @IBOutlet weak var openPositionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryView.alpha      = 1
        holdingView.alpha      = 0
        collateralsView.alpha  = 0
        openPositionView.alpha = 0
    }
    
    // USER INTERFACE
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            summaryView.alpha      = 1
            holdingView.alpha      = 0
            collateralsView.alpha  = 0
            openPositionView.alpha = 0
        } else if (sender.selectedSegmentIndex == 1) {
            holdingView.alpha      = 1
            summaryView.alpha      = 0
            collateralsView.alpha  = 0
            openPositionView.alpha = 0
        } else if (sender.selectedSegmentIndex == 2) {
            collateralsView.alpha  = 1
            holdingView.alpha      = 0
            summaryView.alpha      = 0
            openPositionView.alpha = 0
        } else if (sender.selectedSegmentIndex == 3) {
            openPositionView.alpha = 1
            holdingView.alpha      = 0
            summaryView.alpha      = 0
            collateralsView.alpha  = 0
        }
    }
}
