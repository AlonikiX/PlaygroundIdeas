//
//  LogoutViewController.swift
//  Playground Ideas
//
//  Created by Apple on 14/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit
import PlaygroundIdeasAPI

class LogoutViewController: UIViewController {

    let networkHelper = NetworkReachabilityHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    @IBAction func logout(_ sender: Any) {
//        guard networkHelper.connection != .none else {
//            showAlert(title: "Error", message: "Network is invailable, please connect to the internet first.")
//            return
//        }
        
        let indicator = UIActivityIndicatorView()
        showActivity(indicator: indicator, block: true)
        
        PlaygroundIdeas.Authentication.logout(finished: {
            (data, response, error) in
            
            DispatchQueue.main.async {
                let handler = HTTPHelper()
                handler.handleHTTPResponse(data: data, response: response, error: error, successAction: {
                    let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                    self.present(loginViewController!, animated: true, completion: nil)
                })
                self.dismissActivity(indicator: indicator)
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
