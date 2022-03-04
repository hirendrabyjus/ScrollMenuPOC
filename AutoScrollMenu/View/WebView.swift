//
//  WebView.swift
//  stackview
//
//  Created by Pannaga Bhushana on 15/02/22.
//

import Foundation
import SwiftUI
import WebKit
import Combine

public protocol JSEvent {
    var name: String { get }
}

public protocol JavascriptFuntionConvertible {
    var name: String { get }
}

protocol WebViewHandlerDelegate{
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}

struct WebView: UIViewRepresentable,WebViewHandlerDelegate {
    
    func receivedJsonValueFromWebView(value: [String : Any?]) {
        
    }
    
    func receivedStringValueFromWebView(value: String) {
        
    }
    
    var urlType: WebUrl
    @ObservedObject var viewModel: ViewModel
    var data: Data
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        // Enable javascript in WKWebView to interact with the web app
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        // Here "iOSNative" is our interface name that we pushed to the website that is being loaded
        configuration.userContentController.add(self.makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
        if urlType == .localUrl {
            // Load local website
            if let url = Bundle.main.url(forResource: "Revision", withExtension: "html") {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        } else if urlType == .publicUrl {
            // Load a public website
            if let url = URL(string: "https://www.example.com") {
                webView.load(URLRequest(url: url))
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var delegate: WebViewHandlerDelegate?
        var valueSubscriber: AnyCancellable? = nil
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
            self.delegate = parent
        }
        
        deinit {
            valueSubscriber?.cancel()
            webViewNavigationSubscriber?.cancel()
        }
        
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
            self.parent.viewModel.showLoader.send(false)
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.viewModel.showLoader.send(true)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.viewModel.showLoader.send(true)
            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
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
    }
}

extension WebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Make sure that your passed delegate is called
        if message.name == "iOSNative" {
            if let body = message.body as? [String: Any?] {
                print("JSON value received from web is: \(body)")
            } else if let body = message.body as? String {
                print("String value received from web is: \(body)")
            }
        }
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
            static let trendingRevisionSection = "trendingRevisionSection"
        }
        
        var dict = ["book_name": "",
                     "chapter_name": "",
                     "grade": "Standard XII",
                    "mathjax_question": self.parent.data.mathjaxContent,
                     "qid": 672857,
                     "question": "<p>What is actually GDP ?</p>",
                     "raw_grade": 12,
                     "subject": "Biology"] as [String : Any]
        
        if let value = dict["mathjax_question"] as? String {
            dict["mathjax_question"] = value.encodeSpecialCharacters()
        }
    
        let trendingSearchDetails = ["trending_search": [dict]]
        
        var realtimeSearchPageDictinary: [String: Any] = [:]
        realtimeSearchPageDictinary[Keys.trendingRevisionSection] = trendingSearchDetails
        return realtimeSearchPageDictinary
    }
}
