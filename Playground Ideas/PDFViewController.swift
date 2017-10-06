//
//  PDFViewController.swift
//  Playground Ideas
//
//  Created by Apple on 18/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate {

    var pageData : Any?
    var mode  = 0
    var index = NSNotFound
    
    @IBOutlet var webView: UIWebView!
    
    var hideBars = false
    
    func prepare(content: Any, in mode: Int) {
        self.pageData = content
        self.mode     = mode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        webView.addGestureRecognizer(gesture)
        gesture.delegate                       = self
        
        webView.delegate                       = self
        webView.alpha                          = 0
    }
    
    fileprivate func renderContent() {
        if mode == 0 {
            var pageRequest         = pageData as! URLRequest
            pageRequest.cachePolicy = .returnCacheDataElseLoad
            webView.loadRequest(pageRequest)
        }else {
            let pageFile = pageData as! (html: String, url: URL)
            webView.loadHTMLString(pageFile.html, baseURL: pageFile.url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        renderContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIView.animate(withDuration: 0.4, animations: {
            self.webView.alpha = 1.0
        })
    }
    
    func tap(_ sender: UITapGestureRecognizer) {
        hideBars = !hideBars
        self.tabBarController?.setTabBarVisible(visible: !hideBars, duration: 0.3, animated: true)
        UIView.animate(withDuration: 0.3) {
            self.webView.setNeedsDisplay()
            self.webView.layoutIfNeeded()
        }
        UIApplication.shared.setStatusBarHidden(hideBars, with: .fade)
        self.navigationController?.setNavigationBarHidden(hideBars, animated: true)
        webView.updateConstraints()
        webView.layoutIfNeeded()
        
    }
    
    
    @objc func gestureRecognizer(_: UIGestureRecognizer,  shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
