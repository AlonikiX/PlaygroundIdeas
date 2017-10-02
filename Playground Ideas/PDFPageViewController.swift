//
//  PDFPageViewController.swift
//  Playground Ideas
//
//  Created by Apple on 19/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit
import PlaygroundIdeasAPI

class PDFPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var url : URL?
    var readingPath : (handbook: Handbook,chapterIndex: Int, pageIndex: Int)?
    var readingChapter : Handbook.Chapter?
    var pageRequests : [URLRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for chapter in readingPath!.handbook.chapters {
            let pageCount = chapter.pages
            for pageIndex in 0..<pageCount {
                let page = pageIndex + chapter.startPage
                let request = PlaygroundIdeas.HandbookAPI.Request(handbookSlag: readingPath!.handbook.slag, page: page)
                pageRequests.append(request)
            }
        }
        readingChapter = readingPath!.handbook.chapters[readingPath!.chapterIndex]
        
        print(readingPath!)
        // Do any additional setup after loading the view, typically from a nib.
        // Configure the page view controller and add it as a child view controller.
        self.delegate = self
        self.dataSource = self
        
        let startingViewController: PDFViewController = self.viewControllerAtIndex(readingPath!.pageIndex - 1, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        
//        self.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flipBackward(readingPage : Int) -> Int{
        if readingPage == 0 {
            return NSNotFound
        }
        if readingPage == readingChapter!.startPage - 1 {
            readingPath!.chapterIndex -= 1
            readingChapter = readingPath!.handbook.chapters[readingPath!.chapterIndex]
        }
        readingPath!.pageIndex -= 1
        return readingPage - 1
    }
    
    func flipForward(readingPage : Int) -> Int{
        if readingPage == readingPath!.handbook.pages - 1 {
            return NSNotFound
        }
        if readingPage == readingChapter!.startPage + readingChapter!.pages - 2 {
            readingPath!.chapterIndex += 1
            readingChapter = readingPath!.handbook.chapters[readingPath!.chapterIndex]
        }
        readingPath!.pageIndex += 1
        return readingPage + 1
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> PDFViewController? {
        // Return the data view controller for the given index.
        if (self.pageRequests.count == 0) || (index >= self.pageRequests.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pdfViewController = storyboard.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
        pdfViewController.pageRequest = self.pageRequests[index]
        pdfViewController.index = index
        return pdfViewController
    }
    
    func indexOfViewController(_ viewController: PDFViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
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
        if index == self.pageRequests.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    // MARK: - UIPageViewController delegate methods
    
 /*   func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
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
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
