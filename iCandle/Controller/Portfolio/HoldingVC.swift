//
//  HoldingVC.swift
//  iCandle
//
//  Created by Eashan on 3/9/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class HoldingVC: UIViewController {
    
    @IBOutlet weak var holdingTableView: UITableView!
    
    var scripData            = [String]()
    var netQuantityData      = [Int]()
    var marketValueData      = [Int]()
    var boughtQuantityData   = [Int]()
    var pendingQuantityData  = [Int]()
    var settledQuantityData  = [Int]()
    var marketRateData       = [Int]()
    var soldQuantityData     = [Int]()
    var pendingSellData      = [Int]()
    var unsettedQuantityData = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holdingTableView.delegate   = self
        holdingTableView.dataSource = self
        getHolding()
    }
    
    func getHolding() {
        
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "30e68216-7f43-47c7-9e44-612e79c664b8"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/portfolio/holding")! as URL,
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
                        print("Holding api: \(json)")
                        if let dict = json as? [[String:Any]] {
                            for holding in dict {
                                
                                if let scrip = holding["Scrip"] as? String {
                                    self.scripData.append(scrip)
                                } else {
                                    self.scripData.append("-")
                                }
                                
                                if let netQT = holding["NetQty"] as? Int {
                                    self.netQuantityData.append(netQT)
                                } else {
                                    self.netQuantityData.append(0)
                                }
                                
                                if let mValue = holding["MarketValue"] as? Int {
                                    self.marketValueData.append(mValue)
                                } else {
                                    self.marketValueData.append(0)
                                }
                                
                                if let bQT = holding["BoughtQty"] as? Int {
                                    self.boughtQuantityData.append(bQT)
                                } else {
                                    self.boughtQuantityData.append(0)
                                }
                                
                                if let pBuy = holding["PendingBuy"] as? Int {
                                    self.pendingQuantityData.append(pBuy)
                                } else {
                                    self.pendingQuantityData.append(0)
                                }
                                
                                if let sQT = holding["SettledQty"] as? Int {
                                    self.settledQuantityData.append(sQT)
                                } else {
                                    self.settledQuantityData.append(0)
                                }
                                
                                if let mRate = holding["MarketRate"] as? Int {
                                    self.marketRateData.append(mRate)
                                } else {
                                    self.marketRateData.append(0)
                                }
                                
                                if let soldQT = holding["SoldQty"] as? Int {
                                    self.soldQuantityData.append(soldQT)
                                } else {
                                    self.soldQuantityData.append(0)
                                }
                                
                                if let pendingSell = holding["PendingSell"] as? Int {
                                    self.pendingSellData.append(pendingSell)
                                } else {
                                    self.pendingSellData.append(0)
                                }
                                
                                if let unQT = holding["UnSettledQty"] as? Int {
                                    self.unsettedQuantityData.append(unQT)
                                } else {
                                    self.unsettedQuantityData.append(0)
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.holdingTableView.reloadData()
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

extension HoldingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = holdingTableView.dequeueReusableCell(withIdentifier: "HoldingCell") as! HoldingCell
        
        cell.scripLabel.text       = scripData[indexPath.row]
        cell.netQTLabel.text       = String("Qty: \(netQuantityData[indexPath.row])")
        cell.marketValueLabel.text = String("Mkt Val: \(marketValueData[indexPath.row])")
        cell.boughtQTLabel.text    = String("BoughtQty: \(boughtQuantityData[indexPath.row])")
        cell.pendingBuyLabel.text  = String("PendingBuy:\(pendingQuantityData[indexPath.row])")
        cell.settledQTLabel.text   = String("SettledQty: \(settledQuantityData[indexPath.row])")
        cell.marketRateLabel.text  = String("MarketRate: \(marketRateData[indexPath.row])")
        cell.soldQTLabel.text      = String("SoldQty: \(soldQuantityData[indexPath.row])")
        cell.pendingCellLabel.text = String("PendingSell: \(pendingSellData[indexPath.row])")
        cell.unsettledLabel.text   = String("UnsettledQty: \(unsettedQuantityData[indexPath.row])")
        
        return cell
    }
}
