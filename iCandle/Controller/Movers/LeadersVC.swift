//
//  LeadersVC.swift
//  iCandle
//
//  Created by Eashan on 3/8/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class LeadersVC: UIViewController {
    
    @IBOutlet weak var leaderTableView: UITableView!
    
    var volumeArr = [Int]()
    var nameArr   = [String]()
    var scripArr  = [String]()
    var upperArr  = [NSNumber]()
    var lowerArr  = [NSNumber]()
    var perChange = [NSNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderTableView.delegate   = self
        leaderTableView.dataSource = self
        getLeaders()
    }
    
    func getLeaders() {
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "9792c72c-53a0-4290-9e19-2bda4dbf2db1",
            "ClientCode"   : "C4952"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/TopMovers/topvolume")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        //request.httpBody = postData as Data
        
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
                        print("Working order api: \(json)")
                        if let dict = json as? [[String:Any]] {
                            for order in dict {
                                if let scrip = order["Scrip"] as? String {
                                    self.scripArr.append(scrip)
                                } else {
                                    self.scripArr.append("-")
                                }
                                
                                if let name = order["Name"] as? String {
                                    self.nameArr.append(name)
                                } else {
                                    self.nameArr.append("-")
                                }
                                
                                if let volume = order["Volume"] as? Int {
                                    self.volumeArr.append(volume )
                                } else {
                                    self.volumeArr.append(0)
                                }
                                
                                if let upper = order["LtrdPrice"] as? NSNumber {
                                    self.upperArr.append(upper)
                                } else {
                                    self.upperArr.append(0.00)
                                }
                                
                                if let lower = order["Change"] as? NSNumber {
                                    self.lowerArr.append(lower)
                                } else {
                                    self.lowerArr.append(0.00)
                                }
                                
                                if let perChange = order["PerChange"] as? NSNumber {
                                    self.perChange.append(perChange)
                                } else {
                                    self.perChange.append(0.00)
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.leaderTableView.reloadData()
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

extension LeadersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderTableView.dequeueReusableCell(withIdentifier: "LeaderCell") as! LeaderCell
        
        if ((lowerArr[indexPath.row].floatValue) < 0 ) {
            DispatchQueue.main.async {
                cell.lowerCapLabel.textColor = #colorLiteral(red: 0.9636291862, green: 0.142285049, blue: 0, alpha: 1)
                cell.upperCapLabel.textColor = #colorLiteral(red: 0.9636291862, green: 0.142285049, blue: 0, alpha: 1)
            }
        } else {
            DispatchQueue.main.async {
                cell.lowerCapLabel.textColor = #colorLiteral(red: 0.251649797, green: 0.9774820209, blue: 0, alpha: 1)
                cell.upperCapLabel.textColor = #colorLiteral(red: 0.251649797, green: 0.9774820209, blue: 0, alpha: 1)
            }
        }
        
        cell.scripLabel.text    = scripArr[indexPath.row]
        cell.nameLabel.text     = nameArr[indexPath.row]
        cell.volume.text        = String(volumeArr[indexPath.row])
        cell.upperCapLabel.text = String(upperArr[indexPath.row].floatValue)
        cell.lowerCapLabel.text = String("\(lowerArr[indexPath.row].floatValue)(\(perChange[indexPath.row]))")
        return cell
    }
}
