//
//  LoginViewController.swift
//  Playground Ideas
//
//  Created by Apple on 23/08/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit
import PlaygroundIdeasAPI
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton  : UIButton!
    @IBOutlet weak var signupButton : UIButton!
    @IBOutlet weak var forgotPasswordButton: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let networkHelper = NetworkReachabilityHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius  = 5
        loginButton.clipsToBounds       = true
        
        signupButton.layer.cornerRadius = 5
        signupButton.clipsToBounds      = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    /**
     login to the server, and switch to the home view
     
     - parameter sender: the login button
     */
    public func fuck(notification: Notification) {
        print("fuck")
    }
    
    @IBAction func login(_ sender: Any) {
        
        guard networkHelper.connection != .none else {
            showAlert(title: "Error", message: "Network is invailable, please connect to the internet first.")
            return
        }
        
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if !username.isEmpty, !password.isEmpty {
            let indicator = UIActivityIndicatorView()
            showActivity(indicator: indicator, block: true)
            
            PlaygroundIdeas.Authentication.login(username: username, password: password, finished: {
                data, response, error in
                
                DispatchQueue.main.async {
                    let handler = HTTPHelper()
                    handler.handleHTTPResponse(data: data, response: response, error: error, successAction: {
                        let userCredential = JSON(data: data!)
                        User.currentUser.update(userCredential: userCredential)
                        self.performSegue(withIdentifier: "LoginSuccessSegue", sender: nil)
                    })
                    self.dismissActivity(indicator: indicator)
                }
            })
        }
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        showAlert(title: "Under Construction", message: "This function will be implemented soon...")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
