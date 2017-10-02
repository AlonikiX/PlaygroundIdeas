//
//  Authentication+PlaygroundIdeas.swift
//  Playground Ideas
//
//  Created by Apple on 01/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

extension PlaygroundIdeas {
    public class Authentication: NSObject {
        static public func register(username: String, password: String) {
            
        }
        
        /**
         login to the server by using the login API
         
         - parameter username: user login name
         - parameter password: user login password
         - parameter finished: when login succeeds, this closure will be triggered to handle the API response
         */
        static public func login(username: String, password: String,
                                 finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
            if let apiURI = PlaygroundIdeas.getAPIURI(api: "login") {
                let body    = ["username" : username, "password" : password]
                let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: body)
                
                _ = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    finished(data, response, error)
                }.resume()
            }
        }
        
        /**
         logout from the server by using the logout API
         
         - parameter finished: when logout succeeds, this closure will be triggered to handle the API response
         */
        static public func logout(finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
            if let apiURI = PlaygroundIdeas.getAPIURI(api: "logout") {
                let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: nil)
                
                _ = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    finished(data, response, error)
                }.resume()
            }
        }
    }
}
