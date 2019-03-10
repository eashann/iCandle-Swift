//
//  OrderActivityVC.swift
//  iCandle
//
//  Created by Parves Kawser on 8/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class OrderActivityVC: UIViewController {
    
    @IBOutlet weak var orderActivityTableView: UITableView!
    
    //Orders Activity
    var activityRemainingQuantityArray = [Int]()
    var activityPriceArray             = [Int]()
    var activityScripArray             = [String]()
    var activityMarketArray            = [String]()
    var activityTransactTimeArray      = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        orderActivityTableView.delegate   = self
        orderActivityTableView.dataSource = self
        getOrderActivityAPICall()
    }
    
    func getOrderActivityAPICall() {
        let headers = [
            "ClientCode": "C4952",
            "cache-control": "no-cache",
            "Postman-Token": "ff526138-52fd-4afd-ba47-61a3e7c1074c"
        ]
        
        let postData = NSMutableData(data: "undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constant.baseURL)OrderLogs/orderactivity")! as URL,
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
                        print(json)
                        if let dict = json as? [[String:Any]] {
                            for order in dict {
                                if let scrip = order["Scrip"] as? String {
                                    self.activityScripArray.append(scrip)
                                } else {
                                    self.activityScripArray.append("-")
                                }
                                
                                if let market = order["Market"] as? String {
                                    self.activityMarketArray.append(market)
                                } else {
                                    self.activityMarketArray.append("-")
                                }
                                
                                if let remainingQuantity = order["RemainingQty"] as? Int {
                                    self.activityRemainingQuantityArray.append(remainingQuantity)
                                } else {
                                    self.activityRemainingQuantityArray.append(0)
                                }
                                
                                if let price = order["Price"] as? Int {
                                    self.activityPriceArray.append(price)
                                } else {
                                    self.activityPriceArray.append(0)
                                }
                                
                                if let transactTime = order["TransactTime"] as? String {
                                    self.activityTransactTimeArray.append(transactTime)
                                } else {
                                    self.activityTransactTimeArray.append("-")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.orderActivityTableView.reloadData()
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

extension OrderActivityVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityScripArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderActivityTableView.dequeueReusableCell(withIdentifier: "OrderActivityCell") as! OrderActivityCell
        cell.scripeLabel.text       = activityScripArray[indexPath.row]
        cell.marketLabel.text       = activityMarketArray[indexPath.row]
        //cell.atAfterLabel.text      = String(remainingQuantityArray[indexPath.row])
        cell.atAfterLabel.text      = String("@\(activityPriceArray[indexPath.row])")
        cell.dateLabel.text         = activityTransactTimeArray[indexPath.row]
        cell.buyStatusLabel.text    = String(activityRemainingQuantityArray[indexPath.row])
        return cell
    }
}

