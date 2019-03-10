//
//  WorkingOrderVC.swift
//  iCandle
//
//  Created by Parves Kawser on 8/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class WorkingOrderVC: UIViewController {
    
    //Working Orders
    var remainingQuantityArray = [Int]()
    var priceArray             = [Int]()
    var filledQuantityArray    = [Int]()
    var scripArray             = [String]()
    var marketArray            = [String]()
    var transactTimeArray      = [String]()
    
    @IBOutlet weak var workingOrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workingOrderTableView.delegate   = self
        workingOrderTableView.dataSource = self
        getWorkingOrderAPICall()
    }
    
    func getWorkingOrderAPICall() {
        let headers = [
            "ClientCode": "C4952",
            "cache-control": "no-cache",
            "Postman-Token": "ff526138-52fd-4afd-ba47-61a3e7c1074c"
        ]
        
        let postData = NSMutableData(data: "undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constant.baseURL)OrderLogs/WorkingOrders")! as URL,
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
                print(httpResponse as Any)
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        print("Working order api: \(json)")
                        if let dict = json as? [[String:Any]] {
                            for order in dict {
                                if let scrip = order["Scrip"] as? String {
                                    self.scripArray.append(scrip)
                                } else {
                                    self.scripArray.append("-")
                                }
                                
                                if let market = order["Market"] as? String {
                                    self.marketArray.append(market)
                                } else {
                                    self.marketArray.append("-")
                                }
                                
                                if let remainingQuantity = order["RemainingQty"] as? Int {
                                    self.remainingQuantityArray.append(remainingQuantity)
                                } else {
                                    self.remainingQuantityArray.append(0)
                                }
                                
                                if let price = order["Price"] as? Int {
                                    self.priceArray.append(price)
                                } else {
                                    self.priceArray.append(0)
                                }
                                
                                if let filledQuantity = order["FilledQty"] as? Int {
                                    self.priceArray.append(filledQuantity)
                                } else {
                                    self.priceArray.append(0)
                                }
                                
                                if let transactTime = order["TransactTime"] as? String {
                                    self.transactTimeArray.append(transactTime)
                                } else {
                                    self.transactTimeArray.append("-")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.workingOrderTableView.reloadData()
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

extension WorkingOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workingOrderTableView.dequeueReusableCell(withIdentifier: "WorkingOrderCell") as! WorkingOrderCell
        cell.scripLabel.text     = scripArray[indexPath.row]
        cell.marketLabel.text    = marketArray[indexPath.row]
        cell.atBefore.text       = String(remainingQuantityArray[indexPath.row])
        cell.atAfter.text        = String("@\(priceArray[indexPath.row])")
        cell.dateLabel.text      = transactTimeArray[indexPath.row]
        //cell.buyStatusLabel.text = String(filledQuantityArray[indexPath.row])
        return cell
    }
}
