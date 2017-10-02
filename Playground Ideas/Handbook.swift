//
//  Handbook.swift
//  Playground Ideas
//
//  Created by Apple on 19/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Handbook {
    public class Chapter {
//        let id        : Int
        let chapter   : String
        let startPage : Int
        let pages     : Int
        
        init(json : JSON) {
//            self.id        = json["id"].int!
            self.chapter   = json["chapter"].string!
            self.startPage = json["startPage"].int!
            self.pages     = json["pages"].int!
        }
    }
    
//    let id            : Int
    let handbook      : String
    let slag          : String
    let chapters      : [Chapter]
    let pages         : Int
    
    init(json: JSON) {
        var chapters : [Chapter] = []
        for chapter in json["chapters"].arrayValue {
            chapters.append(Chapter(json: chapter))
        }
//        self.id       = json["id"].int!
        self.handbook = json["handbook"].string!
        self.slag     = json["slag"].string!
        self.chapters = chapters
        self.pages    = json["pages"].int!
    }
    
    convenience init(jsonString: String) {
        let json = JSON.parse(jsonString)
        self.init(json: json)
    }
}


/*
var test = [["handbook":"starter_kit",
             "chapters":[["chapter":"chapter1",
                          "startPage":1,
                          "pages":2],
                         ["chapter":"chapter2",
                          "startPage":3,
                          "pages":2]],
             "pages":4],
            ["handbook":"safety_manual",
             "chapters":[["chapter":"chapter1",
                          "startPage":1,
                          "pages":2],
                         ["chapter":"chapter2",
                          "startPage":3,
                          "pages":2],
                         ["chapter":"chapter2",
                          "startPage":5,
                          "pages":2]],
             "pages":6],
            ["handbook":"playground_builders_handbook",
             "chapters":[["chapter":"chapter1",
                          "startPage":1,
                          "pages":2],
                         ["chapter":"chapter2",
                          "startPage":3,
                          "pages":2]],
             "pages":4],
]

lazy var handbooks = [["handbook":String(),
                       "chapters":[["chapter":String(),
                                    "startPage":Int(),
                                    "pages":Int()]],
                       "pages":Int()],]
*/
