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
        let id        : Int
        let chapter   : String
        let startPage : Int
        let pages     : Int
        var completed     : Bool
        
        init(json : JSON) {
            self.id        = json["id"].int!
            self.chapter   = json["chapter"].string!
            self.startPage = json["startPage"].int!
            self.pages     = json["pages"].int!
            self.completed = json["completed"].boolValue
        }
    }
    
    let id            : Int
    let handbook      : String
    let slag          : String
    let chapters      : [Chapter]
    let pages         : Int
    var downloaded    : Bool
    
    init(json: JSON) {
        var chapters                                 = Array<Chapter>()
        for chapter in json["chapters"].arrayValue {
            chapters.append(Chapter(json : chapter))
        }
        self.id                                      = json["id"].int!
        self.handbook                                = json["handbook"].string!
        self.slag                                    = json["slag"].string!
        self.chapters                                = chapters
        self.pages                                   = json["pages"].int!
        self.downloaded                              = false
    }
    
    convenience init(jsonString: String) {
        let json = JSON(jsonString)
        self.init(json: json)
    }
    
    public func getChapter(by pageIndex: Int) -> Chapter? {
        let acutalIndex = pageIndex + 1;
        
        for chapter in self.chapters {
            if acutalIndex >= chapter.startPage,
                acutalIndex < chapter.startPage + chapter.pages {
                return chapter
            }
        }
        
        return nil
    }
    
    public func setDownloaded(byChecking localHandbooks: [Handbook]?) {
        guard localHandbooks != nil else {
            return
        }
        for localHandbook in localHandbooks! {
            if self.id == localHandbook.id {
                self.downloaded = true
                return
            }
        }
    }
}

