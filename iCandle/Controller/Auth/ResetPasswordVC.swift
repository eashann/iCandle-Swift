//
//  ResetPasswordVC.swift
//  iCandle
//
//  Created by Parves Kawser on 6/3/19.
//  Copyright © 2019 iCandle. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var currentPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonStyle()
        currentPasswordTextfield.delegate = self
        newPasswordTextfield.delegate     = self
        confirmPassword.delegate          = self
    }
    
    func changePassword() {
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "4f511e17-b2c6-4fc9-b1dc-ae89b75e5de8"
        ]
        
        let postData = NSMutableData(data: "UserID=\(LoginModel.currentID)".data(using: String.Encoding.utf8)!)
        postData.append("&NewPassword=\(newPasswordTextfield.text!)".data(using: String.Encoding.utf8)!)
        postData.append("&OldPassword=\(currentPasswordTextfield.text!)".data(using: String.Encoding.utf8)!)
        postData.append("&ConfirmPassword=\(confirmPassword.text!)".data(using: String.Encoding.utf8)!)
        postData.append("&undefined=undefined".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://stock-eye.com/api/login/changepassword/")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error.debugDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode as Any)
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        print(json)
                        
                        if let dict = json as? [String:AnyObject] {
                            if let isChanged = dict["success"] as? [String:Any] {
                                if let message = isChanged["ResultText"] as? String {
                                    DispatchQueue.main.async {
                                        self.spinnerOFF()
                                        Alert.showBasicAlert(on: self, with: "Message", message: "\(message)")
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        Alert.showBasicAlert(on: self, with: "Failed", message: "Something went wrong, please try again later.")
                                    }
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.spinnerOFF()
                            Alert.showBasicAlert(on: self, with: "Failed", message: "Something went wrong, please try again later.")
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    func changeButtonStyle() {
        self.spinner.isHidden = true
        self.sendButtonOutlet.layer.cornerRadius = 10
    }
    
    func spinnerON() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }
    
    func spinnerOFF() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if (currentPasswordTextfield.text!.isEmpty) || (newPasswordTextfield.text!.isEmpty) || ((confirmPassword.text!.isEmpty)) {
            Alert.showBasicAlert(on: self, with: "OOOPS!", message: "Required Field Are Empty!")
        } else {
            spinnerON()
            changePassword()
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension ResetPasswordVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == currentPasswordTextfield) {
            currentPasswordTextfield.text = ""
        } else if (textField == newPasswordTextfield) {
            newPasswordTextfield.text     = ""
        } else if (textField == confirmPassword) {
            confirmPassword.text          = ""
        }
        return true
    }
}
