//
//  KomVC.swift
//  iCandle
//
//  Created by Eashan on 2/28/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class LogsVC: UIViewController {
    
    //Working Orders
    var remainingQuantityArray = [Int]()
    var priceArray             = [Int]()
    var filledQuantityArray    = [Int]()
    var scripArray             = [String]()
    var marketArray            = [String]()
    var transactTimeArray      = [String]()
    
    //Trade Orders
    var tradeRemainingQuantityArray = [Int]()
    var tradePriceArray             = [Int]()
    var tradescripArray             = [String]()
    var tradeMarketArray            = [String]()
    var tradeTransactTimeArray      = [String]()
    
    //Orders Activity
    var activityRemainingQuantityArray = [Int]()
    var activityPriceArray             = [Int]()
    var activityScripArray             = [String]()
    var activityMarketArray            = [String]()
    var activityTransactTimeArray      = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Eashan")
        //getWorkingOrderAPICall()
        //getTradeOrderAPICall()
        //getOrderActivityAPICall()
    }
    
    // USER INTERFACE
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
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
                        print(json)
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
                    } catch {
                        DispatchQueue.main.async {
                            Alert.showBasicAlert(on: self, with: "Login Failed", message: "Something went wrong, please try again later.")
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    func getTradeOrderAPICall() {
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
                        print(json)
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
                    } catch {
                        DispatchQueue.main.async {
                            Alert.showBasicAlert(on: self, with: "Login Failed", message: "Something went wrong, please try again later.")
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
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
                    } catch {
                        DispatchQueue.main.async {
                            Alert.showBasicAlert(on: self, with: "Login Failed", message: "Something went wrong, please try again later.")
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
    }
}
