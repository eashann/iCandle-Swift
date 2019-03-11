//
//  AnnouncementVC.swift
//  iCandle
//
//  Created by Eashan on 3/11/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class AnnouncementVC: UIViewController {
    
    @IBOutlet weak var annoucementTableVIew: UITableView!
    
    var scripX         = [String]()
    var companyX       = [String]()
    var annouceDateX   = [String]()
    var fyX            = [String]()
    var yeX            = [String]()
    var epsX           = [String]()
    var closureStartX  = [String]()
    var closureEndX    = [String]()
    var plBeforeTax    = [String]()
    var plAfterTax     = [String]()
    var agmDate        = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        annoucementTableVIew.delegate = self
        annoucementTableVIew.dataSource = self
        getAnnoucementAPI()
    }
    
    func getAnnoucementAPI() {
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "a59699c8-aa9d-4be4-8962-fd2b84594283"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/media/announcement/")! as URL,
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
                            for announcement in dict {
                                
                                if let scrip = announcement["Scrip"] as? String {
                                    self.scripX.append(scrip)
                                } else {
                                    self.scripX.append("-")
                                }
                                
                                if let company = announcement["Company"] as? String {
                                    self.companyX.append(company)
                                } else {
                                    self.companyX.append("-")
                                }
                                
                                if let annouceDate = announcement["AnnouncementDate"] as? String {
                                    self.annouceDateX.append(annouceDate)
                                } else {
                                    self.annouceDateX.append("-")
                                }
                                
                                if let fy = announcement["FY"] as? String {
                                    self.fyX.append(fy)
                                } else {
                                    self.fyX.append("-")
                                }
                                
                                if let ye = announcement["YEText"] as? String {
                                    self.yeX.append(ye)
                                } else {
                                    self.yeX.append("-")
                                }
                                
                                if let eps = announcement["EPS"] as? String {
                                    self.epsX.append(eps)
                                } else {
                                    self.epsX.append("-")
                                }
                                
                                if let closeStart = announcement["BookClosureStartDate"] as? String {
                                    self.closureStartX.append(closeStart)
                                } else {
                                    self.closureStartX.append("-")
                                }
                                
                                if let closeEnd = announcement["BookClosureEndDate"] as? String {
                                    self.closureEndX.append(closeEnd)
                                } else {
                                    self.closureEndX.append("-")
                                }
                                
                                if let plBefore = announcement["PLBeforeTax"] as? String {
                                    self.plBeforeTax.append(plBefore)
                                } else {
                                    self.plBeforeTax.append("-")
                                }
                                
                                if let plAfter = announcement["PLAfterTax"] as? String {
                                    self.plAfterTax.append(plAfter)
                                } else {
                                    self.plAfterTax.append("-")
                                }
                                
                                if let agmDate = announcement["AGMDate"] as? String {
                                    self.agmDate.append(agmDate)
                                } else {
                                    self.agmDate.append("-")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.annoucementTableVIew.reloadData()
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

extension AnnouncementVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripX.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = annoucementTableVIew.dequeueReusableCell(withIdentifier: "AnnouncementCell") as! AnnouncementCell
        cell.scripCompanyLabel.text  = "\(scripX[indexPath.row]) | \(companyX[indexPath.row])"
        cell.annoucementDate.text    = annouceDateX[indexPath.row]
        cell.fyYELabel.text          = "\(fyX[indexPath.row]) \(yeX[indexPath.row])"
        cell.epsLabel.text           = epsX[indexPath.row]
        cell.blockStartEndDate.text  = closureStartX[indexPath.row]
        cell.blockStartEndDate.text  = closureEndX[indexPath.row]
        cell.plBeforeTaxLabel.text   = plBeforeTax[indexPath.row]
        cell.plAfterTaxLabel.text    = plAfterTax[indexPath.row]
        cell.agmDateLabel.text       = agmDate[indexPath.row]
        return cell
    }
}
