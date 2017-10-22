//
//  Plan+PlaygroundIdeas.swift
//  PlaygroundIdeasAPI
//
//  Created by Apple on 17/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

///This file includes all the APIs for Plans section
extension PlaygroundIdeas {
    static let planResourcesURI = "http://swen90014v-2017plq.cis.unimelb.edu.au/wp-content/uploads/plan/"
    
    static public func requestPlans(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "plan/plans") {
            let params = ["user_id" : userID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func viewPlan(planID: Int, userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "plan/viewPlan") {
            let params = ["user_id" : userID,
                          "plan_id" : planID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func requestMyPlans(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "plan/myPlans") {
            let params = ["user_id" : userID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func create(userID: Int, title: String, accessibility: String, description: String, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "plan/create") {
            let params : [String : Any] = ["user_id"      : userID,
                                          "title"         : title,
                                          "accessibility" : accessibility,
                                          "description"   : description]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
}
