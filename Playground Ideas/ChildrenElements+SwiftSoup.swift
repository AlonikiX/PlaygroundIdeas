//
//  ChildrenElements+SwiftSoup.swift
//  Playground Ideas
//
//  Created by Apple on 06/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SwiftSoup

extension SwiftSoup {
    
    static public func template(ofHTML html: String) -> String {
//        do {
//            let dom = try SwiftSoup.parse(html)
//            let body = try dom.body()
//            try  body!.html("")
//        }catch {
//            print("ERROR: cannot generate HTML template.")
//        }
        return ""
    }
    
    static public func separate(elementByID id: String, inHTML html: String) -> [String] {
        var pagesHTML : [String] = []
        do {
            let dom = try SwiftSoup.parse(html)
            let container = try dom.getElementById(id)
            let children = container!.children()
            
            for child in children {
//                try container!.html(child.outerHtml())
                let singlePageHTML = try dom.text()
                pagesHTML.append(singlePageHTML)
                try singlePageHTML.write(toFile: Handbook.ArchiveDirectory.appendingPathExtension("fuck").appendingPathExtension("html").path, atomically: true, encoding: .utf8)
                print(singlePageHTML)
            }
            
            return pagesHTML
            
        }catch {
            print("Parsing Error!")
            
            return pagesHTML
        }
    }
}
