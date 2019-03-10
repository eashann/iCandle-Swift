//
//  TradeOrderVC.swift
//  iCandle
//
//  Created by Parves Kawser on 8/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class TradeOrderVC: UIViewController {
    
    @IBOutlet weak var tradeOrderTableView: UITableView!
    
    //Trade Orders
    var tradeRemainingQuantityArray = [Int]()
    var tradePriceArray             = [Int]()
    var tradescripArray             = [String]()
    var tradeMarketArray            = [String]()
    var tradeTransactTimeArray      = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tradeOrderTableView.delegate   = self
        tradeOrderTableView.dataSource = self
        getTradeOrderAPICall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func getTradeOrderAPICall() {
        print("Bitch")
        let headers = [
            "ClientCode": "C4952",
            "cache-control": "no-cache",
            "Postman-Token": "ff526138-52fd-4afd-ba47-61a3e7c1074c"
        ]
        
        let postData = NSMutableData(data: "undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constant.baseURL)OrderLogs/TradedOrders")! as URL,
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
                        print("Trade order api: \(json)")
                        if let dict = json as? [[String:Any]] {
                            for order in dict {
                                if let scrip = order["Scrip"] as? String {
                                    self.tradescripArray.append(scrip)
                                } else {
                                    self.tradescripArray.append("-")
                                }
                                
                                if let market = order["Market"] as? String {
                                    self.tradeMarketArray.append(market)
                                } else {
                                    self.tradeMarketArray.append("-")
                                }
                                
                                if let remainingQuantity = order["RemainingQty"] as? Int {
                                    self.tradeRemainingQuantityArray.append(remainingQuantity)
                                } else {
                                    self.tradeRemainingQuantityArray.append(0)
                                }
                                
                                if let transactTime = order["TransactTime"] as? String {
                                    self.tradeTransactTimeArray.append(transactTime)
                                } else {
                                    self.tradeTransactTimeArray.append("-")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.tradeOrderTableView.reloadData()
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

extension TradeOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tradescripArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tradeOrderTableView.dequeueReusableCell(withIdentifier: "TradeOrderCell") as! TradeOrderCell
        cell.scripeLabel.text       = tradescripArray[indexPath.row]
        cell.marketLabel.text       = tradeMarketArray[indexPath.row]
        //cell.atAfterLabel.text      = String(remainingQuantityArray[indexPath.row])
        cell.atAfterLabel.text      = String("@\(tradePriceArray[indexPath.row])")
        cell.dateLabel.text         = tradeTransactTimeArray[indexPath.row]
        cell.buyRemainingLabel.text = String(tradeRemainingQuantityArray[indexPath.row])
        return cell
    }
}
