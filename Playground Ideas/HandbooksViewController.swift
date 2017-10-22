//
//  HandbooksViewController.swift
//  Playground Ideas
//
//  Created by Apple on 09/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit
import PlaygroundIdeasAPI
import SwiftyJSON

class HandbooksViewController: UITableViewController {
    
    let networkHelper = NetworkReachabilityHelper.shared
    
    enum HandbookViewScetion : Int {
        case online = 0
        case download = 1
    }

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let rowDefaultHeight : CGFloat    = 120
    let rowDefaultState               = false
    var expandedData     : [Bool]     = []
    var rowHeightData    : [CGFloat]  = []
    
    var handbooks        : [Handbook] = []
    var onlines          : [Handbook] = []
    var downloads        : [Handbook] = []
    
    var readingPath : (Handbook, Int, Int)?
    
    var presentingSection : HandbookViewScetion?
    
    var isInitiated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentingSection = .online
        
        if !isInitiated {
            
            //load downloaded handbooks
            if FileManager.default.fileExists(atPath: Handbook.ArchivePath.path) {
                downloads = NSKeyedUnarchiver.unarchiveObject(withFile: Handbook.ArchivePath.path) as! [Handbook]
            }
            
            //load online handbooks
            if User.currentUser.isLogged {
                if networkHelper.connection != .none {
                    let indicator = UIActivityIndicatorView()
                    showActivity(indicator: indicator, block: true)
                    
                    PlaygroundIdeas.HandbookAPI.requestHandbooks(userID: User.currentUser.id!, finished: { (data, response, error) in
                        
                        DispatchQueue.main.async {
                            let helper = HTTPHelper()
                            helper.handleHTTPResponse(data: data, response: response, error: error, successAction: {
                                let json = JSON(data!)
                                for jbook in json.arrayValue {
                                    let handbook = Handbook(json: jbook)
                                    handbook.setDownloaded(byChecking: self.downloads)
                                    self.onlines.append(handbook)
                                }
                            })
                            self.handbooks = self.onlines
                            
                            self.segmentedControl.selectedSegmentIndex = 0
                            self.segmentedControl.sendActions(for: .valueChanged)
                            
                            self.dismissActivity(indicator: indicator)
                        }
                    })
                }else {
                    showAlert(title: "Error", message: "Network is invailable, please connect to the internet first.")
                    return
                }
            }else {
                self.segmentedControl.selectedSegmentIndex = 1
                self.segmentedControl.sendActions(for: .valueChanged)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(jumpToChapter), name: NSNotification.Name(rawValue: "ReadChapter"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveHandbookStructure), name: NSNotification.Name(rawValue: "SaveHandbookStructure"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finishChapter), name: NSNotification.Name(rawValue: "FinishChapter"), object: nil)
    }
    
    
    // MARK: - IBActions
    /**
     switch to an other view based on the selected segmented control
     
     - parameter sender: the segmented control
     */
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        presentingSection = HandbookViewScetion(rawValue: segmentedControl.selectedSegmentIndex)!
        if presentingSection == .online {
            self.handbooks = self.onlines
            
            if networkHelper.connection == .none {
                showAlert(title: "Error", message: "Network is invailable, please connect to the internet first.")
                return
            }
            
        }else {
            self.handbooks = self.downloads
        }
        expandedData = Array(repeating: rowDefaultState, count: handbooks.count)
        rowHeightData = Array(repeating: rowDefaultHeight, count: handbooks.count)
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return handbooks.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeightData[indexPath.row]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HandbookCell", for: indexPath) as? HandbookTableViewCell
        if cell == nil {
            cell = HandbookTableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        if indexPath.row % 2 == 0 {
            cell!.closedView.backgroundColor = UIColor(red: 0.962, green: 0.992, blue: 0.999, alpha: 1)
        }else {
            cell!.closedView.backgroundColor = UIColor.white
        }
        
        // Configure the cell...
        let handbook = handbooks[indexPath.row]
        cell!.refreshCellData(with: handbook)
        
        
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let myCell = cell as! HandbookTableViewCell
        myCell.layout()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HandbookTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        if expandedData[indexPath.row] {
            expandedData[indexPath.row] = false
            rowHeightData[indexPath.row] = rowDefaultHeight
        }else {
            expandedData[indexPath.row] = true
            rowHeightData[indexPath.row] = cell.actualHeight
        }
        
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    
    // MARK: - Navigation
    
    //refresh cell if finished a chapter
    func finishChapter(notification: Notification) {
        let handbook = notification.userInfo!["handbook"] as! Handbook
        let chapter = notification.userInfo!["chapter"] as! Handbook.Chapter
        if let index = handbooks.index(of: handbook) {
            chapter.completed = true
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! HandbookTableViewCell
            cell.updateReadingProgress()
        }
        
        if segmentedControl.selectedSegmentIndex == HandbookViewScetion.download.rawValue {
            updateLocalHandbookScheme()
        }
    }
    
    //save handbook to local disk when received this notification
    func saveHandbookStructure(notification: Notification) {
        let handbook = notification.userInfo!["handbook"] as! Handbook
        downloads.append(handbook)
        updateLocalHandbookScheme()
    }
    
    private func updateLocalHandbookScheme() {
        NSKeyedArchiver.archiveRootObject(downloads, toFile: Handbook.ArchivePath.path)
    }
    
    
    func jumpToChapter(notification: Notification) {
        let targetPath = notification.userInfo!
        let handbook   = targetPath["handbook"] as! Handbook
        let chapter    = targetPath["chapter"] as! Int
        let startPage  = targetPath["startPage"] as! Int
        readingPath    = (handbook, chapter, startPage)
        performSegue(withIdentifier: "ReadPDFSegue", sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! PDFPageViewController
        destVC.readingPath = readingPath
        destVC.readingMode = presentingSection!.rawValue
    }
 

}
