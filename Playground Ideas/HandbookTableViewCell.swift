//
//  HandbooksTableViewCell.swift
//  Playground Ideas
//
//  Created by Apple on 15/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit
import PlaygroundIdeasAPI
import SwiftyJSON

class HandbookTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var closedView: UIView!
    @IBOutlet weak var openedView: UIView!

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var chapterTableView: UITableView!
    var chapterTableViewController : ChapterTableViewController?
    
    var handbook : Handbook? {
        get {
            return chapterTableViewController!.handbook
        }
        set {
            chapterTableViewController!.handbook = newValue
//            chapterTableView.reloadData()
        }
    }
    
    var actualHeight : CGFloat {
        get {
            return closedView.frame.height + openedView.frame.height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if chapterTableViewController == nil {
            chapterTableViewController = ChapterTableViewController(style: .plain)
            chapterTableViewController?.tableView = chapterTableView
            chapterTableView.dataSource = chapterTableViewController
            chapterTableView.delegate = chapterTableViewController
        }
    }
    
    @IBAction func download(_ sender: Any) {
        let url = PlaygroundIdeas.HandbookAPI.downloadLink(of: handbook!.slag)
        let destination = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("handbook")
        do {
            try FileManager().createDirectory(at: destination, withIntermediateDirectories: true, attributes: nil)
            let helper = HTTPHelper()
            helper.download(fileAtURL: url, to: destination)
            print(destination.path)
        }catch {
            print("ERROR: cannot create directory.")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
