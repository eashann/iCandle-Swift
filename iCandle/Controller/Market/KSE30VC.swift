//
//  KSE30VC.swift
//  iCandle
//
//  Created by Parves Kawser on 7/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class KSE30VC: UIViewController {
    
    var scripArr    = [String]()
    var marketArr   = [String]()
    var nameArr     = [String]()
    var upperCapArr = [String]()
    var lowerCapArr = [String]()
    var KSE30Arr    = [String]()
    var KMI30Arr    = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getKSE30APICall()
    }
    
    func getKSE30APICall() {
        
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "f13f6bfd-c770-4196-ae7c-bc46adcf0487"
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
                DispatchQueue.main.async {
                    Alert.showBasicAlert(on: self, with: "Can't fetch your data.", message: "Something went wrong, please try again later.")
                    print(error as Any)
                }
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        DispatchQueue.main.async {
                            Alert.showBasicAlert(on: self, with: "Can't fetch your data.", message: "Something went wrong, please try again later.")
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
    }
}
