//
//  UserSettingViewController.swift
//  Playground Ideas
//
//  Created by Khanh Tan Nguyen on 13/9/17.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

class UserSettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var paypalEmail: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var reenterNewPassword: UITextField!
    @IBOutlet weak var btnSave: UIButton!

    var list = ["Australia", "Canada", "United Kingdom", "United States"]

  
    override func viewDidLoad() {
        //scrollView.frame = self.view.frame
        //self.view.addSubview(scrollView)
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews()
    {
        // Assumption is we're supporting a small maximum number of entries
        // so will set height constraint to content size
        // Alternatively can set to another size, such as using row heights and setting frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Manage keyboard and tableView visibility
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        if touch.view != country
        {
            country.endEditing(true)
            country.isHidden = true
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        let countrows : Int = list.count
        return countrows
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.country.text = self.list[row]
        self.dropDown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.country{
            self.dropDown.isHidden = false
            
            //if you dont want the users to see the keyboard type:
            
            textField.endEditing(true)
        }
        
    }

}
