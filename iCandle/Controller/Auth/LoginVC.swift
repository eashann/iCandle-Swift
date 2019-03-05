//
//  LoginVC.swift
//  iCandle
//
//  Created by Eashan on 3/6/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var userIDTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInterfaceSetup()
        authAPICall()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func userInterfaceSetup() {
        loginButtonOutlet.layer.cornerRadius = 10
    }
    
    private func authAPICall() {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "Postman-Token": "310f4992-f0e3-40cd-873c-9ca29cfb56c8"
        ]
        
        let postData = NSMutableData(data: "Password=asif".data(using: String.Encoding.utf8)!)
        postData.append("&UserID=asif".data(using: String.Encoding.utf8)!)
        postData.append("&UUID=2b6f0cc904d137be2e1730235f5664094b831186".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constant.baseURL)login/validate")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode as Any)
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        print("JSON: \(json)")
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
}
