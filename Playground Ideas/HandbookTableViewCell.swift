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
import HGCircularSlider

class HandbookTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cellHC: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var closedView: UIView!
    @IBOutlet weak var openedView: UIView!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var chapterTableView: UITableView!
    
    @IBOutlet weak var readingProgressView: UIView!
    @IBOutlet weak var downloadView: UIView!
    
    @IBOutlet weak var readingProgressLabel: UILabel!
    
    var readingProgressSlider  = CircularSlider()
    var downloadProgressSlider = CircularSlider()
    
    var handbook : Handbook? /*{
        get {
            return chapterTableViewController!.handbook
        }
        set {
            chapterTableViewController!.handbook = newValue
                        reloadCells()
        }
    }*/
    
    var cellHeight : CGFloat = 60
    
    var actualHeight : CGFloat {
        get {
            return closedView.frame.height + menuView.frame.height + (CGFloat)(handbook!.chapters.count) * cellHeight
        }
    }
    
    
    public func updateReadingProgress() {
        
        func calculateReadingProgress() -> Float {
            var finished : Float = 0
            let chapters = handbook!.chapters
            for chapter in chapters{
                if chapter.completed {
                    finished += 1
                }
            }
            return finished / Float(chapters.count)
        }
        
        let readingProgress = Int(calculateReadingProgress() * 100)
        readingProgressLabel.text = "\(readingProgress)%"
        readingProgressSlider.endPointValue = CGFloat(readingProgress >= 100 ? 99 : readingProgress)
        reloadCells()
    }
    
    public func refreshCellData(with handbook: Handbook) {
        self.handbook = handbook
        titleLabel.text = handbook.handbook
        downloadButton.isEnabled = !handbook.downloaded
        
        updateReadingProgress()
        
    }
    
    public func reloadCells() {
        chapterTableView.reloadData()
    }
    
    public func layout() {
        cellHC.constant = actualHeight
        cellHC.isActive = true
        
        chapterTableView.updateConstraints()
    }
    
    fileprivate func setDefaultSliderProperty(_ slider: CircularSlider) {
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.endPointValue = 0
        slider.endThumbImage = nil
        slider.thumbRadius = 0
        slider.thumbLineWidth = 0
        slider.backgroundColor = .clear
        slider.isUserInteractionEnabled = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        chapterTableView.dataSource = self
        chapterTableView.delegate = self
        
        //init the reading progress circular slider
        readingProgressSlider = CircularSlider(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        setDefaultSliderProperty(readingProgressSlider)
        readingProgressSlider.lineWidth = 2
        readingProgressSlider.diskColor = UIColor(red: 0.35, green: 0.88, blue: 0.37, alpha: 1)
        readingProgressSlider.trackFillColor = UIColor(red: 0.45, green: 0.98, blue: 0.47, alpha: 1)
        
        readingProgressSlider.center = readingProgressLabel.center
        readingProgressSlider.layer.zPosition = 5
        readingProgressLabel.layer.zPosition = 10
        readingProgressView.addSubview(readingProgressSlider)
        
        //init the download progress circular slider
        downloadProgressSlider = CircularSlider(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        setDefaultSliderProperty(downloadProgressSlider)
        downloadProgressSlider.lineWidth = 5
        downloadProgressSlider.diskColor = .clear
        downloadProgressSlider.trackFillColor = UIColor(red: 0.210, green: 0.789, blue: 0.793, alpha: 1)
        
        downloadProgressSlider.center = downloadButton.center
        downloadProgressSlider.layer.zPosition = 5
        downloadButton.layer.zPosition = 10
        downloadProgressSlider.isHidden = true
        downloadView.addSubview(downloadProgressSlider)
    }
    
    @IBAction func readAll(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("ReadChapter"), object: self, userInfo: ["handbook":handbook!, "chapter":0, "startPage":1])
    }
    
    
    func switchToDownloading(bool: Bool) {
        if bool {
            downloadButton.isHidden = true
            downloadProgressSlider.isHidden = false
        }else {
            downloadButton.isHidden = false
            downloadProgressSlider.isHidden = true
        }
    }
    
    @IBAction func download(_ sender: Any) {
        if NetworkReachabilityHelper.shared.connection == .none {
            print("Warning: You are using cellular data (mobile data).")
        }
        
        switchToDownloading(bool: true)
        let destination = Handbook.ArchiveDirectory
        do {
            try FileManager().createDirectory(at: destination, withIntermediateDirectories: true, attributes: nil)
            
            let progressHanlde : (Float) -> () = {
                progress in
                let downloadPorgress = Int(progress * 100)
                
                DispatchQueue.main.async {
                    self.downloadProgressSlider.endPointValue = CGFloat(downloadPorgress)
                }
            }
            
            let completion = {
                self.handbook?.downloaded = true
                NotificationCenter.default.post(name: NSNotification.Name("SaveHandbookStructure"), object: self, userInfo: ["handbook":self.handbook!])
                self.switchToDownloading(bool: false)
                self.downloadButton.isEnabled = false
            }
            let errorHandle = {
                self.switchToDownloading(bool: false)
                self.downloadButton.isEnabled = true
            }
            let helper = HTTPHelper(destination: destination, progressHandle: progressHanlde, completion: completion, errorHandle: errorHandle)
            
            PlaygroundIdeas.HandbookAPI.download(handbook: handbook!.slag, delegate: helper)
            
            print(Handbook.ArchiveDirectory.path)
        }catch {
            print("ERROR: cannot create directory.")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.handbook = nil
        self.titleLabel.text = nil
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard handbook != nil else {
            return 0
        }
        return handbook!.chapters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ChapterCell", for: indexPath) as? ChapterTableViewCell
        if cell == nil {
            cell = ChapterTableViewCell(style: .default, reuseIdentifier: "ChapterCell")
        }
        
        // Configure the cell...
        let chapter = handbook!.chapters[indexPath.row]
        cell!.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    
        cell!.chapterLabel.layer.cornerRadius = 5
        cell!.chapterLabel.clipsToBounds = true
        cell!.chapterLabel.text = chapter.chapter
//        cell!.chapterLabel.sizeToFit()
//        cell!.statusLabel.isHidden = !chapter.completed
        
        if chapter.completed {
            cell!.chapterLabel.backgroundColor = UIColor(red: 0.522, green: 0.871, blue: 0.208, alpha: 1)
            cell!.chapterLabel.textColor = UIColor.white
        }else {
            cell!.chapterLabel.backgroundColor = UIColor.white
            cell!.chapterLabel.textColor = UIColor(red: 0.574, green: 0.574, blue: 0.574, alpha: 1)
        }
//        if indexPath.row % 2 == 0 {
//            cell!.backgroundColor = UIColor(red: 0.847, green: 0.142, blue: 0.476, alpha: 0.05)
//            cell!.chapterLabel.textColor = UIColor(red: 0.847, green: 0.142, blue: 0.476, alpha: 0.8)
//        }else {
//            cell!.backgroundColor = UIColor.white
//            cell!.chapterLabel.textColor = UIColor(red: 0.847, green: 0.142, blue: 0.476, alpha: 0.8)
//        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapter = handbook!.chapters[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("ReadChapter"), object: self, userInfo: ["handbook":handbook!, "chapter":indexPath.row, "startPage":chapter.startPage])
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

