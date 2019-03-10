//
//  KMI30VC.swift
//  iCandle
//
//  Created by Parves Kawser on 7/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class KMI30VC: UIViewController {
    
    @IBOutlet weak var KMI30TableView: UITableView!
    
    var kmiScripArr    = [String]()
    var kmiMarketArr   = [String]()
    var kmiNameArr     = [String]()
    var kmiUpperCapArr = [String]()
    var kmiLowerCapArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        KMI30TableView.delegate   = self
        KMI30TableView.dataSource = self
        fetchKMIData()
    }
    
    func fetchKMIData() {
        if let path = Bundle.main.path(forResource: "mover", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print("KSE 30 API: \(jsonResult)")
                if let dict = jsonResult as? [[String:Any]] {
                    for kse in dict {
                        if let indexKMI30 = kse["IndexKMI30"] as? Int {
                            if (indexKMI30 == 1) {
                                
                                if let scripe = kse["Scrip"] as? String {
                                    self.kmiScripArr.append(scripe)
                                } else {
                                    self.kmiScripArr.append("-")
                                }
                                
                                if let market = kse["Market"] as? String {
                                    self.kmiMarketArr.append(market)
                                } else {
                                    self.kmiMarketArr.append("-")
                                }
                                
                                if let name = kse["Name"] as? String {
                                    self.kmiNameArr.append(name)
                                } else {
                                    self.kmiNameArr.append("-")
                                }
                                
                                if let upperCap = kse["UpperCap"] as? String {
                                    self.kmiUpperCapArr.append(upperCap)
                                } else {
                                    self.kmiUpperCapArr.append("-")
                                }
                                
                                if let lowerCap = kse["LowerCap"] as? String {
                                    self.kmiLowerCapArr.append(lowerCap)
                                } else {
                                    self.kmiLowerCapArr.append("-")
                                }
                                
                            } else {
                                print("Not KSE30")
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.KMI30TableView.reloadData()
                    }
                }
            } catch {
                print("error:\(error)")
            }
        }
    }
}


extension KMI30VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kmiScripArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KMI30TableView.dequeueReusableCell(withIdentifier: "KMI30Cell") as! KMI30Cell
        cell.scripLabel.text    = kmiScripArr[indexPath.row]
        cell.marketLabel.text   = kmiMarketArr[indexPath.row]
        cell.nameLabel.text     = kmiNameArr[indexPath.row]
        //cell.upperCapLabel.text = kmiUpperCapArr[indexPath.row]
        //cell.lowerCapLabel.text = kmiLowerCapArr[indexPath.row]
        return cell
    }
}
