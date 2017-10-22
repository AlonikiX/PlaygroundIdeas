//
//  Handbook.swift
//  Playground Ideas
//
//  Created by Apple on 19/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Handbook : NSObject, NSCoding {
    
    static let ArchiveDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("handbook")
    static let ArchivePath = ArchiveDirectory.appendingPathComponent("scheme.plist")
    
    @objc(_TtCC16Playground_Ideas8Handbook7Chapter)public class Chapter : NSObject, NSCoding {
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(id, forKey        : PropertyKey.id)
            aCoder.encode(chapter, forKey   : PropertyKey.chapter)
            aCoder.encode(startPage, forKey : PropertyKey.startPage)
            aCoder.encode(pages, forKey     : PropertyKey.pages)
            aCoder.encode(completed, forKey : PropertyKey.completed)
        }
        
        public required convenience init?(coder aDecoder: NSCoder) {
            let id        = aDecoder.decodeInteger(forKey        : PropertyKey.id)
            let chapter   = aDecoder.decodeObject(forKey   : PropertyKey.chapter) as! String
            let startPage = aDecoder.decodeInteger(forKey : PropertyKey.startPage)
            let pages     = aDecoder.decodeInteger(forKey     : PropertyKey.pages)
            let completed = aDecoder.decodeBool(forKey : PropertyKey.completed)
            self.init(id: id, chapter: chapter, startPage: startPage, pages: pages, completed: completed)
        }
        
        let id        : Int
        let chapter   : String
        let startPage : Int
        let pages     : Int
        var completed     : Bool
        
        struct PropertyKey {
            static let id        = "id"
            static let chapter   = "chapter"
            static let startPage = "startPage"
            static let pages     = "pages"
            static let completed = "completed"
        }
        
        init(id: Int, chapter: String, startPage: Int, pages: Int, completed: Bool) {
            self.id = id
            self.chapter = chapter
            self.startPage = startPage
            self.pages = pages
            self.completed = completed
        }
        
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
    
    
    struct PropertyKey {
        static let id         = "id"
        static let handbook   = "handbook"
        static let slag       = "slag"
        static let chapters   = "chapters"
        static let pages      = "pages"
        static let downloaded = "downloaded"
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(handbook, forKey: PropertyKey.handbook)
        aCoder.encode(slag, forKey: PropertyKey.slag)
        aCoder.encode(chapters, forKey: PropertyKey.chapters)
        aCoder.encode(pages, forKey: PropertyKey.pages)
        aCoder.encode(downloaded, forKey: PropertyKey.downloaded)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let id         = aDecoder.decodeInteger(forKey: PropertyKey.id)
        let handbook   = aDecoder.decodeObject(forKey: PropertyKey.handbook) as! String
        let slag       = aDecoder.decodeObject(forKey : PropertyKey.slag) as! String
        let chapters   = aDecoder.decodeObject(forKey : PropertyKey.chapters) as! [Chapter]
        let pages      = aDecoder.decodeInteger(forKey : PropertyKey.pages)
        let downloaded = aDecoder.decodeBool(forKey : PropertyKey.downloaded)
        self.init(id: id, handbook: handbook, slag: slag, chapters: chapters, pages: pages, downloaded: downloaded)
    }
    
    init(id: Int, handbook: String, slag: String, chapters: [Chapter], pages: Int, downloaded: Bool) {
        self.id = id
        self.handbook = handbook
        self.slag = slag
        self.chapters = chapters
        self.pages = pages
        self.downloaded = downloaded
    }
    
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

