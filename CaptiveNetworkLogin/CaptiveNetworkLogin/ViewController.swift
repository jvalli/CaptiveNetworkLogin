//
//  ViewController.swift
//  CaptiveNetworkLogin
//
//  Created by Jerónimo Valli on 5/12/16.
//  Copyright © 2016 Jerónimo Valli. All rights reserved.
//

import UIKit
import Reachability

class ViewController: UIViewController {
    
    // MARK: - # Constants -
    
    let kCaptiveNetworkLoginDelay = 1.0
    
    // MARK: - # Variables -
    
    var reachability = Reachability.reachabilityForInternetConnection()

    // MARK: - # Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if reachability.isReachableViaWiFi() || reachability.isReachableViaWWAN() {
            print("Reachability Connected at Launch")
            
            if reachability.isInterventionRequired() {
                performSelector(#selector(ViewController.displayCaptiveNetworkLogin), withObject: nil, afterDelay: kCaptiveNetworkLoginDelay)
            }
        }
        
        reachability.reachableBlock = { (let reach: Reachability!) -> Void in
            print("Reachability Status: Connected")
            
            if self.reachability.isInterventionRequired() {
                self.displayCaptiveNetworkLogin()
            }
        }
        
        reachability.unreachableBlock = { (let reach: Reachability!) -> Void in
            print("Reachability Status: Disconnected")
        }
        
        reachability.startNotifier()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - # Private Methods -

    func displayCaptiveNetworkLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier(HotspotConnectionViewController.kViewControllerIdentifier)
        presentViewController(viewController, animated: true, completion: nil)
    }
}

