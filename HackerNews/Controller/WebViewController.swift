//
//  WebViewController.swift
//  HackerNews
//
//  Created by Sandeep Singh Bansal on 5/5/19.
//  Copyright © 2019 Sandeep Singh Bansal. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var urlToLoad : URLRequest?
    
    // MARK: - Private properties
    /// Progress view reflecting the current loading progress of the web view.
    let progressView = UIProgressView(progressViewStyle: .default)
    
    /// The observation object for the progress of the web view (we only receive notifications until it is deallocated).
    private var estimatedProgressObserver: NSKeyValueObservation?
    
    var webView: WKWebView! = {
        let webview = WKWebView()
        return webview
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupProgressView() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor                                 = Color.progressViewTintColor.value
        navigationBar.addSubview(progressView)
        
        progressView.isHidden = true
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            
            progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -2),
            progressView.heightAnchor.constraint(equalToConstant: 3.0)
            ])
    }
    
    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor  = UIColor.white
        
        setupProgressView()
        setupEstimatedProgressObserver()
        
        self.view.addSubview(webView)
        self.view = webView
    }
    
    func loadURLForWebView(_ urlString: URL) {
        let myRequest = URLRequest(url: urlString)
        webView.navigationDelegate = self
        webView.load(myRequest)
    }
    
}


/// By implementing the `WKNavigationDelegate` we can update the visibility of the `progressView` according to the `WKNavigation` loading progress.
/// The view-visibility updates are based on my gist [fxm90/UIView+AnimateIsHidden.swift](https://gist.github.com/fxm90/723b5def31b46035cd92a641e3b184f6)
extension WebViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        if progressView.isHidden {
            // Make sure our animation is visible.
            progressView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.33,
                       animations: {
                        self.progressView.alpha = 1.0
        })
    }
    
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        UIView.animate(withDuration: 0.33,
                       animations: {
                        self.progressView.alpha = 0.0
        },
                       completion: { isFinished in
                        // Update `isHidden` flag accordingly:
                        //  - set to `true` in case animation was completly finished.
                        //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
                        self.progressView.isHidden = isFinished
        })
    }
}
