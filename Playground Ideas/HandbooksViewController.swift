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
    enum HandbookViewScetion : Int {
        case online = 0
        case download = 1
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let rowDefaultHeight : CGFloat    = 50
    let rowDefaultState               = false
    var expandedData     : [Bool]     = []
    var rowHeightData    : [CGFloat]  = []
    
    var handbooks        : [Handbook] = []
    
    var readingPath : (Handbook, Int, Int)?
    
    var presentingSection : HandbookViewScetion?
    
    var isInitiated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentingSection = .online
        
        if !isInitiated {
            let indicator = UIActivityIndicatorView()
            showActivity(indicator: indicator, block: true)
            
            PlaygroundIdeas.HandbookAPI.requestHandbooks(finished: { (data, response, error) in
                
                DispatchQueue.main.async {
                    let handler = HTTPResponseHandler()
                    handler.handleHTTPResponse(data: data, response: response, error: error, successAction: {
                        let json = JSON(data!)
                        for jbook in json.arrayValue {
                            self.handbooks.append(Handbook(json: jbook))
                        }
                    })
                    self.expandedData = Array(repeating: self.rowDefaultState, count: self.handbooks.count)
                    self.rowHeightData = Array(repeating: self.rowDefaultHeight, count: self.handbooks.count)
                    self.tableView.reloadData()
                    self.dismissActivity(indicator: indicator)
                }
            })
        }
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.sendActions(for: .valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(jumpToChapter), name: NSNotification.Name(rawValue: "ReadChapter"), object: nil)
    }
    
    // MARK: - IBActions
    /**
     switch to an other view based on the selected segmented control
     
     - parameter sender: the segmented control
     */
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        presentingSection = HandbookViewScetion(rawValue: segmentedControl.selectedSegmentIndex)!
        if presentingSection == .online {
        }else {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HandbookCell", for: indexPath) as! HandbookTableViewCell
        
        // Configure the cell...
        let handbook = handbooks[indexPath.row]
        cell.handbook = handbook
        cell.titleLabel.text = handbooks[indexPath.row].handbook
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HandbookTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        if expandedData[indexPath.row] {
            expandedData[indexPath.row] = false
            rowHeightData[indexPath.row] = 50
        }else {
            expandedData[indexPath.row] = true
            rowHeightData[indexPath.row] = cell.actualHeight
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    
    // MARK: - Navigation
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
    }
 

}
