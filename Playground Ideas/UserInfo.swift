//
//  UserInfo.swift
//  Playground Ideas
//
//  Created by Apple on 14/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserInfo : NSObject {
    var username : String?
    var id       : Int?
//    var nonce    : String?
    
    static public var userInfo : UserInfo?
    
    private override init() {
        super.init()
    }
    
    static public func sharedUserInfo() -> UserInfo{
        if userInfo == nil {
            userInfo = UserInfo()
        }
        return userInfo!
    }
    
    public func update(userCredential : JSON?) {
        if let uc = userCredential {
            self.username = uc["username"].string
            self.id       = uc["id"].int
//            self.nonce    = uc["nonce"].string
        } else {
            fatalError("warning: user credential is empty!")
        }
    }
    
}
