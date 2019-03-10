//
//  KSE30VC.swift
//  iCandle
//
//  Created by Parves Kawser on 7/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class KSE30VC: UIViewController {
    
    @IBOutlet weak var KSE30TableView: UITableView!
    
    var kseScripArr    = [String]()
    var kseMarketArr   = [String]()
    var kseNameArr     = [String]()
    var kseUpperCapArr = [String]()
    var kseLowerCapArr = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        KSE30TableView.delegate   = self
        KSE30TableView.dataSource = self
        fetchKSEData()
    }
    
    func getKSE30APICall() {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "Postman-Token": "42fd13b6-ef92-4c9a-8661-4623ac389184"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/data/scripinfo")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
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
                        let json = try JSONSerialization.jsonObject(with: data, options:[])
                        print("KSE 30 API: \(json)")
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
    
    func fetchKSEData() {
        if let path = Bundle.main.path(forResource: "mover", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print("KSE 30 API: \(jsonResult)")
                if let dict = jsonResult as? [[String:Any]] {
                    for kse in dict {
                        if let indexKMI30 = kse["IndexKMI30"] as? Int {
                            if (indexKMI30 == 0) {
                                
                                if let scripe = kse["Scrip"] as? String {
                                    self.kseScripArr.append(scripe)
                                } else {
                                    self.kseScripArr.append("-")
                                }
                                
                                if let market = kse["Market"] as? String {
                                    self.kseMarketArr.append(market)
                                } else {
                                    self.kseMarketArr.append("-")
                                }
                                
                                if let name = kse["Name"] as? String {
                                    self.kseNameArr.append(name)
                                } else {
                                    self.kseNameArr.append("-")
                                }
                                
                                if let upperCap = kse["UpperCap"] as? String {
                                    self.kseUpperCapArr.append(upperCap)
                                } else {
                                    self.kseUpperCapArr.append("-")
                                }
                                
                                if let lowerCap = kse["LowerCap"] as? String {
                                    self.kseLowerCapArr.append(lowerCap)
                                } else {
                                    self.kseLowerCapArr.append("-")
                                }
                                
                            } else {
                                print("Not KSE30")
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.KSE30TableView.reloadData()
                    }
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
}

extension KSE30VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kseScripArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KSE30TableView.dequeueReusableCell(withIdentifier: "KSE30Cell") as! KSE30Cell
        cell.scripLabel.text    = kseScripArr[indexPath.row]
        cell.marketLabel.text   = kseMarketArr[indexPath.row]
        cell.nameLabel.text     = kseNameArr[indexPath.row]
        //cell.upperCapLabel.text = kseUpperCapArr[indexPath.row]
        //cell.lowerCapLabel.text = kseLowerCapArr[indexPath.row]
        return cell
    }
}
