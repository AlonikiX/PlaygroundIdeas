//
//  PDFPageViewController.swift
//  Playground Ideas
//
//  Created by Apple on 19/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit
import PlaygroundIdeasAPI
import SwiftSoup

class PDFPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var readingMode                   = 0
    var readingPath    : (handbook : Handbook, chapterIndex : Int, pageIndex : Int)?
    var readingChapter : Handbook.Chapter?
    var pagesData   : [Any] = []
    
    var currentVC : PDFViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if readingMode == 0 {
            //online reading mode, prepare url requests for pages
            for chapter in readingPath!.handbook.chapters {
                let pageCount = chapter.pages
                for pageIndex in 0..<pageCount {
                    let page = pageIndex + chapter.startPage
                    let request = PlaygroundIdeas.HandbookAPI.Request(handbookSlag: readingPath!.handbook.slag, page: page)
                    pagesData.append(request)
                }
            }
            
        }else {
            //download reading mode, prepare html for pages
            do {
                var file = try FileManager().url(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                file.appendPathComponent("handbook/" + readingPath!.handbook.slag)
                print(file.path)
                let baseURL = URL.init(fileURLWithPath: file.path)
                let html = try String.init(contentsOf: baseURL)
                pagesData = SwiftSoup.separate(elementByID: "page-container", inHTML: html)
                
            }catch {
                print("Error: Cannot load files!")
            }
            
        }
        
        
        readingChapter = readingPath!.handbook.chapters[readingPath!.chapterIndex]
        
        print(readingPath!)
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.delegate   = self
        self.dataSource = self
        
        let startingViewController: PDFViewController = self.viewControllerAtIndex(readingPath!.pageIndex - 1, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> PDFViewController? {
        // Return the data view controller for the given index.
        if (self.pagesData.count == 0) || (index >= self.pagesData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pdfViewController = storyboard.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
        pdfViewController.pageData = self.pagesData[index]
        pdfViewController.index = index
        
        if let currentChapter = readingPath!.handbook.getChapter(by: index) {
            if readingChapter !== currentChapter {
                if !readingChapter!.completed {
                    readingChapter!.completed = true
                    PlaygroundIdeas.HandbookAPI.record(userID: User.currentUser.id!, readingHandbook: readingPath!.handbook.id, completedChapter: readingChapter!.id, finished: {_,_,_ in return})
                }
                readingChapter = currentChapter
            }
        }
        
        if index == pagesData.count - 1 {
            if !readingChapter!.completed {
                readingChapter!.completed = true
                PlaygroundIdeas.HandbookAPI.record(userID: User.currentUser.id!, readingHandbook: readingPath!.handbook.id, completedChapter: readingChapter!.id, finished: {_,_,_ in return})
            }
        }
        currentVC = pdfViewController
        return pdfViewController
    }
    
    func indexOfViewController(_ viewController: PDFViewController) -> Int {
        return viewController.index
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! PDFViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! PDFViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pagesData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    // MARK: - UIPageViewController delegate methods
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.viewControllers![0]
            let viewControllers = [currentViewController]
            self.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
            
            self.isDoubleSided = false
            return .min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.viewControllers![0] as! PDFViewController
        var viewControllers: [UIViewController]
        
        let indexOfCurrentViewController = self.indexOfViewController(currentViewController)
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.pageViewController(self, viewControllerAfter: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.pageViewController(self, viewControllerBefore: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        
        return .mid
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
