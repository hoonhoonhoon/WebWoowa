//
//  ViewController.swift
//  WebWoowa
//
//  Created by eyemac on 2017. 3. 31..
//  Copyright © 2017년 rollmind. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    let webURLString: String = "https://realm.io"

    var backgroundLabel: UILabel!
    var webView: WKWebView!

    override func viewDidLoad() {

        super.viewDidLoad()

        backgroundLabel = UILabel(frame: self.view.bounds)
        backgroundLabel.font = UIFont.systemFont(ofSize: 24)
        backgroundLabel.textAlignment = .center
        self.view.addSubview(backgroundLabel)
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundLabel.lineBreakMode = .byWordWrapping
        backgroundLabel.numberOfLines = 0

        var views: [String : Any] = ["Label": backgroundLabel]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[Label]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[Label]|", options: [], metrics: nil, views: views))

        webView = WKWebView(frame: self.view.bounds)
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .clear

        self.view.addSubview(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false

        views = ["Web": webView]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[Web]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[Web]|", options: [], metrics: nil, views: views))

        webView.uiDelegate = self
        webView.navigationDelegate = self

        guard let url = URL(string: webURLString) else {
            webView.loadHTMLString("<body><font size=32><b>URL을 확인해보면 어떨까? -> \(webURLString)</b><font></body>", baseURL: nil)
            return
        }
        self.backgroundLabel.text = "\(webURLString)를 열어보려고 노력중이니까 진정하고 기다려봐"
        webView.load(.init(url: url))

        webView.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(String(describing: navigationAction.navigationType))
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if self.webView.alpha != 1.0 {
            UIView.animate(withDuration: 0.25, animations: {
                self.webView.alpha = 1.0
            })
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.backgroundLabel.text = error.localizedDescription
        UIView.animate(withDuration: 0.25) {
            webView.alpha = 0.0
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.backgroundLabel.text = error.localizedDescription
        UIView.animate(withDuration: 0.25) {
            webView.alpha = 0.0
        }
    }
}

extension WKNavigationType: CustomDebugStringConvertible {

    public var debugDescription: String {
        var typeString = "WKNavigationType"
        switch self {
        case .backForward:
            typeString += ".backForward"
        case .formResubmitted:
            typeString += ".formResubmitted"
        case .formSubmitted:
            typeString += ".formSubmitted"
        case .linkActivated:
            typeString += ".linkActivated"
        case .other:
            typeString += ".other"
        case .reload:
            typeString += ".reload"
        }
        return typeString
    }
}
