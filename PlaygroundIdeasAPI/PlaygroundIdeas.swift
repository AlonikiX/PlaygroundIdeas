//
//  PlaygroundIdeas
//  Playground Ideas
//
//  Created by Apple on 01/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

public class PlaygroundIdeas: NSObject {
//    static let baseAPIDomainURL = "http://localhost/wordpress/wp-json/api/v1/"
    static let baseAPIDomainURL = "http://swen90014v-2017plq.cis.unimelb.edu.au/wp-json/api/v1/"
    
    private override init() {
        super.init()
    }
    
    static func getAPIURI(api: String) -> URL?{
        return URL(string: PlaygroundIdeas.baseAPIDomainURL + api)
    }
    
    static func makeHTTPURLRequest(method: HTTPMethods, url: URL, params: [String : String]?) -> URLRequest {
        
        var request : URLRequest?
        
        switch method {
        case .GET:
            var tempURL = url.absoluteString;
            if params != nil {
                tempURL += "?"
                for (key,value) in params! {
                    tempURL += "\(key)=\(value)"
                }
            }
            print(tempURL)
            request = URLRequest(url: URL(string: tempURL)!)
            
        case .POST:
            var body = ""
            if params != nil {
                if params != nil {
                    for (key,value) in params! {
                        body += "\(key)=\(value)&"
                    }
                }
            }
            request = URLRequest(url: url)
            request!.httpBody = !body.isEmpty ? body.data(using: .utf8) : nil
        }
        
        request!.httpMethod = method.rawValue
        return request!
    }
}
