//
//  WebViewController.swift
//  AutoScrollMenu
//
//  Created by Pannaga Bhushana on 23/03/22.
//

import UIKit
import WebKit
import Combine

class WebViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var urlType: WebUrl = .localUrl
    var viewModel = ViewModel()
    var revisionData: [RevisionData] = []
    var jsMessageHandler = JSHandler()
    var htmlFileName: String = ""
    var webView: WKWebView?
    var valueSubscriber: AnyCancellable? = nil
    var webViewNavigationSubscriber: AnyCancellable? = nil
    
    static func instantiate(type: WebUrl,data: [RevisionData]) -> WebViewController
    {
        let webVC =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webVC.urlType = type
        webVC.revisionData = data
        return webVC
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpWebView()
        if urlType == .localUrl {
                   // Load local website
                   if let url = Bundle.main.url(forResource: HtmlFileName.cardView.fileName, withExtension: "html") {
                       webView?.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        }
//        self.view.layoutIfNeeded()
        self.containerView.addSubview(webView!)
        
        webView?.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addConstraints([
                NSLayoutConstraint.init(item: webView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: webView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: webView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: webView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)])
}
                

    func setUpWebView() {
        webView = WKWebView(frame: self.containerView.bounds, configuration: jsMessageHandler.webViewConfiguration)
        webView?.navigationDelegate = self
        webView?.allowsBackForwardNavigationGestures = true
        
        if revisionData.first?.type == "RevisionList" {
            webView?.scrollView.isScrollEnabled = true
        } else {
            webView?.scrollView.isScrollEnabled = false
        }
        webView?.backgroundColor = .clear
    }
    
    deinit {
        valueSubscriber?.cancel()
        webViewNavigationSubscriber?.cancel()
        jsMessageHandler.cleanUp()
    }

}

extension WebViewController: WKNavigationDelegate {
    
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Page loaded so no need to show loader anymore
            let param = loadParamsInToWebView()
            let test = "displayRevisions"
            let paramString = "\(test)(" + "'\(encodeDictionary(param)!)'" + ")"
            webView.evaluateJavaScript(paramString) { (response, error) in
                if let error = error {
                    print("Error getting title")
                    print(error.localizedDescription)
                }
                
                guard let title = response as? String else {
                    return
                }
            }
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
           
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            viewModel.showLoader.send(true)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            viewModel.showLoader.send(true)
            self.webViewNavigationSubscriber = viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
                switch navigation {
                case .backward:
                    if webView.canGoBack {
                        webView.goBack()
                    }
                case .forward:
                    if webView.canGoForward {
                        webView.goForward()
                    }
                }
            })
        }
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Suppose you don't want your user to go a restricted site
            if let host = navigationAction.request.url?.host {
                if host == "restricted.com" {
                    // Navigation is cancelled
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    
    func encodeDictionary(_ dictionary: [String: Any]) -> String? {
        guard let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) else {
                return ""
            }
        let base64Encoded = theJSONData.base64EncodedString()
        return base64Encoded
    }
    
    private func loadParamsInToWebView() -> [String : Any] {
        struct Keys {
            static let revisionSection = "revisionSection"
        }
        
        var revisionDetails: [Any] = [Any]()
        for obj in self.revisionData {
            var dict = ["type": obj.type ?? "",
                        "qid": "\(obj.id)",
                        "mathjax_question": obj.mathjaxContent,
            ] as [String : Any]
            
            if let value = dict["mathjax_question"] as? String {
                dict["mathjax_question"] = value.encodeSpecialCharacters()
            }
            revisionDetails.append(dict)
        }
        
        let revisions = ["trending_search": revisionDetails]
        
        var revisionsDictinary: [String: Any] = [:]
        revisionsDictinary[Keys.revisionSection] = revisions
        return revisionsDictinary
    }
}

