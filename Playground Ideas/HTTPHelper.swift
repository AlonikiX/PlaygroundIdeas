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
    private var completion : () -> () = {}
    private var errorHandle : () -> () = {}
    private var progressHandle : (Float) -> () = {_ in }
    
    override init() {
        super.init()
    }
    
    init(destination: URL, completion: @escaping () -> ()) {
        self.downloadDestination = destination
        self.completion = completion
    }
    
    convenience init(destination: URL, completion: @escaping () -> (), errorHandle: @escaping () -> ()) {
        self.init(destination: destination, completion: completion)
        self.errorHandle = errorHandle
    }
    
    convenience init(destination: URL, progressHandle : @escaping (Float) -> (), completion: @escaping () -> (), errorHandle: @escaping () -> ()) {
        self.init(destination: destination, completion: completion, errorHandle: errorHandle)
        self.progressHandle = progressHandle
    }
    
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
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressHandle(progress)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        if let destinationDirectory = self.downloadDestination {
            // Here you can move your downloaded file
            do {
                let fileDestination = destinationDirectory.appendingPathComponent(downloadTask.response!.suggestedFilename!)
                
                try FileManager().moveItem(at: location, to: fileDestination)
                
                SSZipArchive.unzipFile(atPath: fileDestination.path, toDestination: destinationDirectory.path)
                
                try FileManager().removeItem(at: fileDestination)
                
                self.completion()
                
            }catch {
                print("ERROR: Download file cannot be deployed correctly.")
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            errorHandle()
        }
    }
}
