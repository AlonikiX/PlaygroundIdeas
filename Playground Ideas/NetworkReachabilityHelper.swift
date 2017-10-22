//
//  NetworkReachabilityHelper.swift
//  Playground Ideas
//
//  Created by Apple on 12/10/2017.
//  Copyright © 2017 PlaygroundIdeasQuoll. All rights reserved.
//

import Foundation

class NetworkReachabilityHelper {
    
    private static let networkReachabilityHelper = NetworkReachabilityHelper()
    
    private var reachability : Reachability
    
    public var connection : Reachability.Connection {
        return reachability.connection
    }
    
    private init() {
        reachability = Reachability()!
    }
    
    public static var shared : NetworkReachabilityHelper {
        get {
            return networkReachabilityHelper
        }
    }
    
    public func observe(by observer: Any, handle: Selector) {
        NotificationCenter.default.addObserver(observer, selector: handle, name: .reachabilityChanged, object: reachability)
    }
    
    public func stopObservation(of observer: Any) {
        NotificationCenter.default.removeObserver(observer, name: .reachabilityChanged, object: reachability)
    }
    
    public func start() {
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    public func stop() {
        reachability.stopNotifier()
    }
    
}
