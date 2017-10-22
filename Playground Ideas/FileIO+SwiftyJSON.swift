//
//  FileIO+SwiftyJSON.swift
//  Playground Ideas
//
//  Created by Apple on 06/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    
    static public func saveJSON(of contents : [Any], to path: String) {
        let json = JSON(contents)
        let str = json.rawString()
//        let jsonString = JSON(contents).description
//        let data = jsonString.data(using: .utf8)!
//        if let file = FileHandle(forWritingAtPath: path) {
//            file.write(data)
//        }
    }
    
    static public func loadJSON(from path: String) -> JSON? {
        if let file = FileHandle(forReadingAtPath: path) {
            let data = file.readDataToEndOfFile()
            return JSON(data)
        }
        return nil
    }
    
}
