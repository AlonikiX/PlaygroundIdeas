//
//  Bulletin+UIViewController.swift
//  Playground Ideas
//
//  Created by Apple on 31/08/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     present a bulletin board to show more information
     */
    public func showBulletinBoard() {
        let alert = UIAlertController(title          : "Bulletin Board",
                                      message        : "Under Construction!\nWe will implement this function soon.",
                                      preferredStyle : .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    public func showActivity(indicator: UIActivityIndicatorView, block: Bool) {
        if block == true {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.red
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    public func dismissActivity(indicator: UIActivityIndicatorView) {
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        indicator.removeFromSuperview()
        indicator.stopAnimating()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
