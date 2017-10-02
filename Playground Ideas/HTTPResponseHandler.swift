//
//  HTTPResponseHandler.swift
//  Playground Ideas
//
//  Created by Apple on 07/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

class HTTPResponseHandler: NSObject {
    public func handleHTTPResponse(data: Data?, response: URLResponse?, error: Error?,
                                   successAction: (() -> Void),
                                   failureAction: (() -> Void)? = nil) {
        //remove this code in release mode
        print(String(data: data!, encoding: .utf8)!)
        
        guard error == nil else {
            print("Handling Errors!")
            return
        }
        if response != nil {
            let httpResponse = response as! HTTPURLResponse
            switch httpResponse.statusCode {
            case 200:
                successAction()
            default:
                if failureAction != nil {
                    failureAction!()
                } else {
                    print("no success response returned!")
                }
            }
        }
        
    }
}
