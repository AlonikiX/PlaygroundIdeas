//
//  Handbook+PlaygroundIdeas.swift
//  Playground Ideas
//
//  Created by Apple on 17/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

extension PlaygroundIdeas {
    static let baseHandbookURI = "http://swen90014v-2017plq.cis.unimelb.edu.au/handbook/"
    static let handbookResourcesURI = "http://swen90014v-2017plq.cis.unimelb.edu.au/wp-content/uploads/handbook/"
    static let downloadFileFormat = ".zip"
    
    public class HandbookAPI : NSObject {
        static public func requestHandbooks(userID: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
            if let apiURI = PlaygroundIdeas.getAPIURI(api: "requestHandbooks") {
                let params = ["user_id" : userID]
                let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: apiURI, params: params)
                
                URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    finished(data, response, error)
                }.resume()
            }
        }
        
        static public func Request(handbookSlag: String, page: Int) -> URLRequest {
            let uriString = "\(baseHandbookURI)\(handbookSlag)/\(page)"
            let request = URLRequest(url: URL(string: uriString)!)
//            request.cachePolicy = .returnCacheDataElseLoad
            
            return request
        }
        
        static public func record(userID: Int, readingHandbook: Int, completedChapter: Int, finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
            if let uri = PlaygroundIdeas.getAPIURI(api: "recordReadingProgress") {
                let params = ["user_id":userID,
                              "handbook_id":readingHandbook,
                              "chapter_id":completedChapter]
                let request = PlaygroundIdeas.makeHTTPURLRequest(method: .POST, url: uri, params: params)
                
                URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    
                    finished(data, response, error)
                }.resume()
            }
        }
        
        static public func downloadLink(of handbookSlag: String) -> URL {
            let link  = handbookResourcesURI + handbookSlag + downloadFileFormat
            return URL(string: link)!
        }
    }
}
