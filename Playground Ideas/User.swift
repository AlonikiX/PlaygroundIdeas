//
//  UserInfo.swift
//  Playground Ideas
//
//  Created by Apple on 14/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SwiftyJSON

class User : NSObject {
    var username : String?
    var id       : Int?
    var isLogged = false
    
    static private var user : User?
    
    private override init() {
        super.init()
    }
    
    static public var currentUser : User {
        get {
            if user == nil {
                user = User()
            }
            return user!
        }
    }
    
    public func update(userCredential : JSON?) {
        if let uc = userCredential {
            self.username = uc["username"].string
            self.id       = uc["id"].int
            self.isLogged = true
        } else {
            fatalError("warning: user credential is empty!")
        }
    }
    
}
