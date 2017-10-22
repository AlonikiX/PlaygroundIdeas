//
//  FileIO+Array.swift
//  Playground Ideas
//
//  Created by Apple on 10/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

extension Array {
    
    public static func load(contentOf path : String) -> Array? {
        if FileManager.default.fileExists(atPath: path) {
            return NSArray.init(contentsOfFile: path) as? Array
        }
        return nil
    }
    
    public func saveContent(to path : String, mode : String) {
        if !FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        let array = self as NSArray
        if mode == "override" {
            array.write(toFile: path, atomically: true)
        }else {
            let handle = FileHandle(forUpdatingAtPath: path)
            handle?.seekToEndOfFile()
            
            handle?.write(Data())
        }
    }
}
