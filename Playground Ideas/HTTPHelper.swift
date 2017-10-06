//
//  HTTPResponseHandler.swift
//  Playground Ideas
//
//  Created by Apple on 07/09/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation
import SSZipArchive

class HTTPHelper: NSObject, URLSessionDownloadDelegate {
    private var downloadDestination : URL?
    
    public func handleHTTPResponse(data: Data?, response: URLResponse?, error: Error?,
                                   successAction: (() -> Void),
                                   failureAction: (() -> Void)? = nil) {
        //remove this code in release mode
        print(String(data: data!, encoding: .utf8)!)
        
        guard error == nil else {
            print("Handling Errors!")
            return
        }
        if response != nil {
            let httpResponse = response as! HTTPURLResponse
            switch httpResponse.statusCode {
            case 200:
                successAction()
            default:
                if failureAction != nil {
                    failureAction!()
                } else {
                    print("no success response returned!")
                }
            }
        }
        
    }
    
    func download(fileAtURL url: URL, to destination: URL) {
        self.downloadDestination = destination
        
        let config = URLSessionConfiguration.background(withIdentifier: "Download Task")
        
        // create session by instantiating with configuration and delegate
        let session = Foundation.URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        
        let downloadTask = session.downloadTask(with: url as URL)
        
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let destinationDirectory =  self.downloadDestination as! URL
        
        // Here you can move your downloaded file
        do {
            let fileDestination = destinationDirectory.appendingPathComponent(downloadTask.response!.suggestedFilename!)
            
            try FileManager().moveItem(at: location, to: fileDestination)
            
            SSZipArchive.unzipFile(atPath: fileDestination.path, toDestination: destinationDirectory.path)
            
            try FileManager().removeItem(at: fileDestination)
            
        }catch {
            print("ERROR: Download file cannot be deployed correctly.")
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("completed: ERROR: \(error.debugDescription).")
    }
}
