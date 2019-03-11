//
//  NewsVC.swift
//  iCandle
//
//  Created by Eashan on 3/11/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var scripX         = [String]()
    var companyX       = [String]()
    var annouceDateX   = [String]()
    var messageX       = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        getAnnoucementAPI()
    }
    
    func getAnnoucementAPI() {
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "a59699c8-aa9d-4be4-8962-fd2b84594283"
        ]
        
        let postData = NSMutableData(data: "ClientCode=C4952".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/media/news/")! as URL,
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
                                
                                if let scrip = announcement["Title"] as? String {
                                    self.scripX.append(scrip)
                                } else {
                                    self.scripX.append("-")
                                }
                                
                                if let company = announcement["Company"] as? String {
                                    self.companyX.append(company)
                                } else {
                                    self.companyX.append("-")
                                }
                                
                                if let annouceDate = announcement["Date"] as? String {
                                    self.annouceDateX.append(annouceDate)
                                } else {
                                    self.annouceDateX.append("-")
                                }
                                
                                if let message = announcement["Message"] as? String {
                                    self.messageX.append(message)
                                } else {
                                    self.messageX.append("-")
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.newsTableView.reloadData()
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

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scripX.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.scripCompanyLabel.text  = scripX[indexPath.row]
        cell.annoucementDate.text    = annouceDateX[indexPath.row]
        cell.allTextLabel.text       = messageX[indexPath.row]
        return cell
    }
}


