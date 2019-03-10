//
//  SummaryVC.swift
//  iCandle
//
//  Created by Eashan on 3/9/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class SummaryVC: UIViewController {
    
    @IBOutlet weak var summaryTableView: UITableView!
    
    var labelArr = [String]()
    var valueArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        summaryTableView.delegate  = self
        summaryTableView.dataSource = self
        summaryTableView.tableFooterView = UIView()
        getSummary()
    }
    
    func getSummary() {
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "2c0b1236-d874-4307-951b-9c848175ed82"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/portfolio/exposure")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode as Any)
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        print("Summary api: \(json)")
                        if let dict = json as? [[String:Any]] {
                            for summary in dict {
                                
                                if let label = summary["Label"] as? String {
                                    self.labelArr.append(label)
                                } else {
                                    self.labelArr.append("-")
                                }
                                
                                if let value = summary["Value"] as? String {
                                    self.valueArr.append(value)
                                } else {
                                    self.valueArr.append("-")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.summaryTableView.reloadData()
                        }
                    } catch {
                        DispatchQueue.main.async {
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
    }
}

extension SummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = summaryTableView.dequeueReusableCell(withIdentifier: "SummaryCell") as! SummaryCell
        cell.label.text  = labelArr[indexPath.row]
        cell.volume.text = valueArr[indexPath.row]
        return cell
    }
}



