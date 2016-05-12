//
//  HotspotConnection.swift
//  CaptiveNetworkLogin
//
//  Created by Jerónimo Valli on 5/12/16.
//  Copyright © 2016 Jerónimo Valli. All rights reserved.
//

import UIKit

class HotspotConnectionViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: - # Constants -
    
    static let kViewControllerIdentifier = "HotspotConnectionViewController"
    let kCaptivePortalAttempToAccess = "http://www.apple.com/library/test/success.html"
    let kUserAgent = "User-Agent"
    let kUserAgentValue = "CaptiveNetworkSupport/1.0 wispr"
    let kTimeoutInterval: NSTimeInterval = 60
    
    // MARK: - # Variables -
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - # Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSMutableURLRequest(URL: NSURL(string: kCaptivePortalAttempToAccess)!, cachePolicy:NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval:kTimeoutInterval)
        request.setValue(kUserAgentValue, forHTTPHeaderField: kUserAgent)
        webView.loadRequest(request)
    }
    
    // MARK: - # IBActions -
    
    @IBAction func onClickButtonDone() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - # UIWebViewDelegate -
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("Started Loading WebView")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("Finished Loading WebView")
        activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("An error occurred while loading the webview \(error)")
        activityIndicator.stopAnimating()
        let message = "Failed to open web site. Please try again later."
        let alert = UIAlertController(title: "Unavailable", message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}
