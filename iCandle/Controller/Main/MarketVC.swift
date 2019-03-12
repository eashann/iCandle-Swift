//
//  MarketVC.swift
//  iCandle
//
//  Created by Eashan on 2/28/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {

    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var KSE30View: UIView!
    @IBOutlet weak var KMI30VIew: UIView!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlOutlet.selectedSegmentIndex = 1
        KSE30View.alpha = 1
        favView.alpha   = 0
        KMI30VIew.alpha = 0
    }
    
    // USER INTERFACE
    override var prefersStatusBarHidden: Bool { return true }
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0) {
            favView.alpha   = 1
            KSE30View.alpha = 0
            KMI30VIew.alpha = 0
        } else if (sender.selectedSegmentIndex == 1) {
            KSE30View.alpha = 1
            favView.alpha   = 0
            KMI30VIew.alpha = 0
        } else if (sender.selectedSegmentIndex == 2) {
            KMI30VIew.alpha = 1
            favView.alpha   = 0
            KSE30View.alpha = 0
        }
    }
    
    @IBAction func rightMoreButtonPressed(_ sender: UIButton) {
            let toMainControllerVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            self.present(toMainControllerVC, animated: false, completion: nil)
    }
}
