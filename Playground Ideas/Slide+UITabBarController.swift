//
//  Slide+UITabBarController.swift
//  Playground Ideas
//
//  Created by Apple on 05/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

extension UITabBarController {
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animation
        UIView.animate(withDuration: animated ? duration : 0.0) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}
