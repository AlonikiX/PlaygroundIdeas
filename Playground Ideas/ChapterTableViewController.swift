//
//  ChapterTableViewController.swift
//  Playground Ideas
//
//  Created by Apple on 17/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

class ChapterTableViewController: UITableViewController {

    var handbook : Handbook?
    
    var cellHeight : CGFloat = 50
    
    var actualHeight : CGFloat {
        get{
            return (CGFloat)(handbook!.chapters.count) * cellHeight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant: actualHeight).isActive = true
        tableView.updateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard handbook != nil else {
            return 0
        }
        return handbook!.chapters.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath) as? ChapterTableViewCell
        if cell == nil {
            cell = ChapterTableViewCell(style: .default, reuseIdentifier: "ChapterCell")
        }
        
        // Configure the cell...
        let chapter = handbook!.chapters[indexPath.row]
        cell!.chapterLabel.text = chapter.chapter
//        cell!.statusLabel.isHidden = !chapter.completed
        
        if indexPath.row % 2 == 0 {
            cell!.chapterLabel.backgroundColor = UIColor(red: 0.847, green: 0.142, blue: 0.476, alpha: 0.05)
            cell!.chapterLabel.textColor = UIColor(red: 0.847, green: 0.142, blue: 0.476, alpha: 0.8)
        }else {
            cell!.chapterLabel.backgroundColor = UIColor.white
            cell!.chapterLabel.textColor = UIColor(red: 0.847, green: 0.142, blue: 0.476, alpha: 0.8)
        }
        return cell!
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapter = handbook!.chapters[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("ReadChapter"), object: self, userInfo: ["handbook":handbook!, "chapter":indexPath.row, "startPage":chapter.startPage])
    }

    
}
