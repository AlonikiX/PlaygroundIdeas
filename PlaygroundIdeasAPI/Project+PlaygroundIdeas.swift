//
//  Project+PlaygroundIdeas.swift
//  PlaygroundIdeasAPI
//
//  Created by Apple on 17/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

///This file includes all the APIs for Projects section
extension PlaygroundIdeas {
    static let projectResourcesURI = "http://swen90014v-2017plq.cis.unimelb.edu.au/wp-content/uploads/project/"
    
    static public func requestProjects(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "project/projects") {
            let params = ["user_id" : userID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func viewProject(projectID: Int, userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "project/viewProject") {
            let params = ["user_id"    : userID,
                          "project_id" : projectID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func requestMyProjects(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "project/myProjects") {
            let params = ["user_id" : userID]
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
    
    static public func createProject(form: [String:Any], finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let apiURI = PlaygroundIdeas.getAPIURI(api: "project/create") {
            let params = form
            let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                finished(data, response, error)
                }.resume()
        }
    }
}
