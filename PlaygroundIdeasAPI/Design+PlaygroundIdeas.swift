//
//  Design+PlaygroundIdeas.swift
//  PlaygroundIdeasAPI
//
//  Created by Apple on 17/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

///This file includes all the APIs for Designs section
extension PlaygroundIdeas {
    static let designResourcesURI = "http://swen90014v-2017plq.cis.unimelb.edu.au/wp-content/uploads/design/"
    
    static public func requestDesigns(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "design/designs") {
            let params = ["user_id" : userID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func viewDesign(designID: Int, userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "design/viewDesign") {
            let params = ["user_id"   : userID,
                          "design_id" :designID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func requestFavourites(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "design/favourits") {
            let params = ["user_id" : userID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func favour(designID: Int, userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "design/favour") {
            let params = ["user_id"   : userID,
                          "design_id" : designID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func disfavour(designID: Int, userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "design/disfavour") {
            let params = ["user_id"   : userID,
                          "design_id" : designID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
