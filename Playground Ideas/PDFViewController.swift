//
//  PDFViewController.swift
//  Playground Ideas
//
//  Created by Apple on 18/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController, UIWebViewDelegate {

    var pageRequest : URLRequest?
    var index = NSNotFound
    
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.alpha = 0
        // Do any additional setup after loading the view.
        pageRequest?.cachePolicy = .returnCacheDataElseLoad
//        webView.scalesPageToFit = true
//        webView.scrollView.contentSize.width = webView.frame.size.width
        webView.scalesPageToFit = true
        webView.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        webView.loadRequest(pageRequest!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finish load!")
        UIView.animate(withDuration: 0.4, animations: {
            self.webView.alpha = 1.0
        })
        
        webView.contentMode = .scaleAspectFit
        let js =
            "var meta = document.createElement('meta'); " +
        "meta.setAttribute( 'name', 'viewport' ); " +
        "meta.setAttribute( 'content', 'width = device-width, initial-scale = 1, user-scalable = yes' ); " +
        "document.getElementsByTagName('head')[0].appendChild(meta)";
        
//        webView.stringByEvaluatingJavaScript(from: js)
        
        print("content width:\(webView.scrollView.contentSize.width)\n")
        print("screen width: \(webView.frame.size.width)\n")
//        let ratio = 5.0 / (webView.scrollView.contentSize.width / webView.frame.size.width)
//        print(ratio)
//        let js2 =
//            "var meta = document.createElement('meta'); " +
//                "meta.setAttribute( 'name', 'viewport' ); " +
//                "meta.setAttribute( 'content', 'width = device-width, initial-scale = \(ratio), user-scalable = yes' ); " +
//        "document.getElementsByTagName('head')[0].appendChild(meta)";
//        
//        webView.stringByEvaluatingJavaScript(from: js2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
