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
    @IBOutlet weak var userIDTextView: UIView!
    @IBOutlet weak var passwordTextView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDTextfield.delegate   = self
        passwordTextfield.delegate = self
        userInterfaceSetup()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    func getDeviceID() -> String { return UIDevice.current.identifierForVendor!.uuidString }
    
    private func userInterfaceSetup() {
        spinner.isHidden = true
        loginButtonOutlet.layer.cornerRadius = 10
    }
    
    private func authAPICall() {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "Postman-Token": "310f4992-f0e3-40cd-873c-9ca29cfb56c8"
        ]
        
        let postData = NSMutableData(data: "Password=\(passwordTextfield.text!)".data(using: String.Encoding.utf8)!)
        postData.append("&UserID=\(userIDTextfield.text!)".data(using: String.Encoding.utf8)!)
        postData.append("&UUID=\(getDeviceID())".data(using: String.Encoding.utf8)!)
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
                print(error.debugDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode as Any)
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        if let dict = json as? [String:AnyObject] {
                            if let loginResponse = dict["success"] as? [String:Any] {
                                if let enableLogin = loginResponse["LoginResponse"] as? String {
                                    if (enableLogin == "true") {
                                        DispatchQueue.main.async {
                                            self.spinnerOFF()
                                            self.toMainControllerVC()
                                        }
                                    } else {
                                        DispatchQueue.main.async {
                                            self.spinnerOFF()
                                            Alert.showBasicAlert(on: self, with: "Login Failed", message: "Please enter valid credentials")
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.spinnerOFF()
                                        Alert.showBasicAlert(on: self, with: "Login Failed", message: "Something went wrong, please try again later.")
                                    }
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.spinnerOFF()
                            Alert.showBasicAlert(on: self, with: "Login Failed", message: "Something went wrong, please try again later.")
                            print("error:\(error)")
                        }
                    }
                }
            }
        })
        
        dataTask.resume()
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
    
    func checkTextfieldValidity() {
        if (userIDTextfield.text == "") || (passwordTextfield.text == "") {
            Alert.showBasicAlert(on: self, with: "Empty userID or password", message: "Please enter valid userID and password.")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        checkTextfieldValidity()
        spinnerON()
        authAPICall()
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
    private func toMainControllerVC() {
//        let toMainControllerVC: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
//        self.present(toMainControllerVC, animated: false, completion: nil)
        let toMainControllerVC: UIViewController = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "NewsTabView") as! NewsTabView
        self.present(toMainControllerVC, animated: false, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == userIDTextfield) {
            DispatchQueue.main.async {
                self.userIDTextfield.text = ""
                self.userIDTextView.backgroundColor = #colorLiteral(red: 1, green: 0.2509803922, blue: 0.5058823529, alpha: 1)
            }
        } else if (textField == passwordTextfield) {
            DispatchQueue.main.async {
                self.passwordTextfield.text = ""
                self.passwordTextView.backgroundColor = #colorLiteral(red: 1, green: 0.2509803922, blue: 0.5058823529, alpha: 1)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == userIDTextfield) {
            DispatchQueue.main.async {
                self.userIDTextView.backgroundColor = #colorLiteral(red: 0.8861869574, green: 0.8863358498, blue: 0.8861673474, alpha: 1)
            }
        } else if (textField == passwordTextfield) {
            DispatchQueue.main.async {
                self.passwordTextView.backgroundColor = #colorLiteral(red: 0.8861869574, green: 0.8863358498, blue: 0.8861673474, alpha: 1)
            }
        }
    }
}
