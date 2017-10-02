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
    
    public class HandbookAPI : NSObject {
        static public func requestHandbooks(finished: @escaping (Data?, URLResponse?, Error?) -> Void) {
            if let apiURI = PlaygroundIdeas.getAPIURI(api: "requestHandbooks") {
                let request = PlaygroundIdeas.makeHTTPURLRequest(method: .GET, url: apiURI, params: nil)
                
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
    }
}
