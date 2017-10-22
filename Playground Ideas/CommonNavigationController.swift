//
//  CommonNavigationController.swift
//  Playground Ideas
//
//  Created by Apple on 08/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

class CommonNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let menuItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(switchToMenuView))
        menuItem.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = menuItem
        
        for viewController in viewControllers {
            viewController.navigationItem.rightBarButtonItems = self.navigationItem.rightBarButtonItems
        }
    }

    func switchToMenuView() {
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") //MenuViewController
        pushViewController(menuViewController!, animated: true)
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
