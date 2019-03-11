//
//  NewsTabView.swift
//  iCandle
//
//  Created by Parves Kawser on 11/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class NewsTabView: UIViewController {
    
    @IBOutlet weak var newsSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var annuncementView: UIView!
    @IBOutlet weak var boardMeetingView: UIView!
    @IBOutlet weak var newsVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        annuncementView.alpha   = 1
        boardMeetingView.alpha = 0
        newsVIew.alpha = 0
    }
    
    @IBAction func newsSegmentPressed(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0) {
            annuncementView.alpha   = 1
            boardMeetingView.alpha = 0
            newsVIew.alpha = 0
        } else if (sender.selectedSegmentIndex == 1) {
            boardMeetingView.alpha = 1
            annuncementView.alpha   = 0
            newsVIew.alpha = 0
        } else if (sender.selectedSegmentIndex == 2) {
            newsVIew.alpha = 1
            annuncementView.alpha   = 0
            boardMeetingView.alpha = 0
        }
    }
}

