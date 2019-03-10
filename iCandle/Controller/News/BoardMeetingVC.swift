//
//  BoardMeetingVC.swift
//  iCandle
//
//  Created by Eashan on 3/11/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class BoardMeetingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "0c3adfbd-1e7d-4283-a474-da46d3f7f693"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/media/boardmeeting/")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
}