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
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    func updateUIView(_ webView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
        if urlType == .localUrl {
            // Load local website
            if let url = Bundle.main.url(forResource: "TrendingSearch", withExtension: "html") {
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
            let test = "displayTrendingSearch"
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
    
    private func loadParamsInToWebView() -> [String : Any]{
        struct Keys {
            static let trendingSearchSection = "trendingSearchSection"
        }

        var dict1 = ["book_name": "",
                     "chapter_name": "",
                     "grade": "Standard XII",
                     "mathjax_question": "<p>What is actually GDP ? What is actually GDP ?What is actually GDP ?What is actually GDP ?What is actually GDP ?What is actually GDP ?What is actually GDP ?What is actually GDP ?What is actually GDP ?What is actually GDP ?</p>",
                     "qid": 672857,
                     "question": "<p>What is actually GDP ?</p>",
                     "raw_grade": 12,
                     "subject": "Biology"] as [String : Any]
        
        var dict2 = ["book_name": "",
                     "chapter_name": "",
                     "grade": "Standard XII",
                     "mathjax_question": "<span id=\"MathJax-Element-1-Frame\" class=\"mjx-full-width mjx-chtml\" style=\"min-width: 12.319em;\"><span id=\"MJXc-Node-58967\" class=\"mjx-math\" style=\"width: 100%;\"><span id=\"MJXc-Node-58968\" class=\"mjx-mrow\" style=\"width: 100%;\"><span class=\"mjx-stack\" style=\"width: 100%; vertical-align: -1.401em;\"><span class=\"mjx-block\"><span class=\"mjx-box\"><span id=\"MJXc-Node-58969\" class=\"mjx-mtext\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.446em; padding-bottom: 0.372em;\">Subtract:&#xA0;</span></span><span id=\"MJXc-Node-58970\" class=\"mjx-mn\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span><span id=\"MJXc-Node-58971\" class=\"mjx-msubsup\"><span class=\"mjx-base\"><span id=\"MJXc-Node-58972\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span></span><span class=\"mjx-sup\" style=\"font-size: 70.7%; vertical-align: 0.513em; padding-left: 0px; padding-right: 0.071em;\"><span id=\"MJXc-Node-58973\" class=\"mjx-mn\" style=\"\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span><span id=\"MJXc-Node-58974\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-58975\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">6</span></span><span id=\"MJXc-Node-58976\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">&#x2212;</span></span><span id=\"MJXc-Node-58977\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">4</span></span><span id=\"MJXc-Node-58978\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span><span id=\"MJXc-Node-58979\" class=\"mjx-mtext\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.446em; padding-bottom: 0.372em;\">&#xA0;from&#xA0;</span></span></span></span><span class=\"mjx-block\" style=\"padding-top: 0.442em;\"><span class=\"mjx-box\"><span id=\"MJXc-Node-58980\" class=\"mjx-mspace\" style=\"width: 0px; height: 0px;\"></span><span id=\"MJXc-Node-58981\" class=\"mjx-mn\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">3</span></span><span id=\"MJXc-Node-58982\" class=\"mjx-msubsup\"><span class=\"mjx-base\"><span id=\"MJXc-Node-58983\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span></span><span class=\"mjx-sup\" style=\"font-size: 70.7%; vertical-align: 0.513em; padding-left: 0px; padding-right: 0.071em;\"><span id=\"MJXc-Node-58984\" class=\"mjx-mn\" style=\"\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span><span id=\"MJXc-Node-58985\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">&#x2212;</span></span><span id=\"MJXc-Node-58986\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">6</span></span><span id=\"MJXc-Node-58987\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span><span id=\"MJXc-Node-58988\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-58989\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">8.</span></span></span></span></span></span></span></span><br><ol type=\"A\"><li><span id=\"MathJax-Element-2-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-58990\" class=\"mjx-math\"><span id=\"MJXc-Node-58991\" class=\"mjx-mrow\"><span id=\"MJXc-Node-58992\" class=\"mjx-msubsup\"><span class=\"mjx-base\"><span id=\"MJXc-Node-58993\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span></span><span class=\"mjx-sup\" style=\"font-size: 70.7%; vertical-align: 0.513em; padding-left: 0px; padding-right: 0.071em;\"><span id=\"MJXc-Node-58994\" class=\"mjx-mn\" style=\"\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span><span id=\"MJXc-Node-58995\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">&#x2212;</span></span><span id=\"MJXc-Node-58996\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">8</span></span><span id=\"MJXc-Node-58997\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span><span id=\"MJXc-Node-58998\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-58999\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span></span></li><li><span id=\"MathJax-Element-3-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-59000\" class=\"mjx-math\"><span id=\"MJXc-Node-59001\" class=\"mjx-mrow\"><span id=\"MJXc-Node-59002\" class=\"mjx-msubsup\"><span class=\"mjx-base\"><span id=\"MJXc-Node-59003\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span></span><span class=\"mjx-sup\" style=\"font-size: 70.7%; vertical-align: 0.513em; padding-left: 0px; padding-right: 0.071em;\"><span id=\"MJXc-Node-59004\" class=\"mjx-mn\" style=\"\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span><span id=\"MJXc-Node-59005\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">&#x2212;</span></span><span id=\"MJXc-Node-59006\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span><span id=\"MJXc-Node-59007\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span><span id=\"MJXc-Node-59008\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-59009\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span></span></li><li><span id=\"MathJax-Element-4-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-59010\" class=\"mjx-math\"><span id=\"MJXc-Node-59011\" class=\"mjx-mrow\"><span id=\"MJXc-Node-59012\" class=\"mjx-msubsup\"><span class=\"mjx-base\"><span id=\"MJXc-Node-59013\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span></span><span class=\"mjx-sup\" style=\"font-size: 70.7%; vertical-align: 0.513em; padding-left: 0px; padding-right: 0.071em;\"><span id=\"MJXc-Node-59014\" class=\"mjx-mn\" style=\"\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span><span id=\"MJXc-Node-59015\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-59016\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span><span id=\"MJXc-Node-59017\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span><span id=\"MJXc-Node-59018\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-59019\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span></span></li><li><span id=\"MathJax-Element-5-Frame\" class=\"mjx-chtml\"><span id=\"MJXc-Node-59020\" class=\"mjx-math\"><span id=\"MJXc-Node-59021\" class=\"mjx-mrow\"><span id=\"MJXc-Node-59022\" class=\"mjx-mn\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span><span id=\"MJXc-Node-59023\" class=\"mjx-msubsup\"><span class=\"mjx-base\"><span id=\"MJXc-Node-59024\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span></span><span class=\"mjx-sup\" style=\"font-size: 70.7%; vertical-align: 0.513em; padding-left: 0px; padding-right: 0.071em;\"><span id=\"MJXc-Node-59025\" class=\"mjx-mn\" style=\"\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span><span id=\"MJXc-Node-59026\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">&#x2212;</span></span><span id=\"MJXc-Node-59027\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span><span id=\"MJXc-Node-59028\" class=\"mjx-mi\"><span class=\"mjx-char MJXc-TeX-math-I\" style=\"padding-top: 0.225em; padding-bottom: 0.298em;\">x</span></span><span id=\"MJXc-Node-59029\" class=\"mjx-mo MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.298em; padding-bottom: 0.446em;\">+</span></span><span id=\"MJXc-Node-59030\" class=\"mjx-mn MJXc-space2\"><span class=\"mjx-char MJXc-TeX-main-R\" style=\"padding-top: 0.372em; padding-bottom: 0.372em;\">2</span></span></span></span></span></li></ol>",
                     "qid": 692296,
                     "question": "<p>Integrate xtanx</p>",
                     "raw_grade": 12,
                     "subject": "Mathematics"] as [String : Any]
        
        if let value = dict1["mathjax_question"] as? String {
            dict1["mathjax_question"] = value.encodeSpecialCharacters()
        }
        
        if let value = dict2["mathjax_question"] as? String {
            dict2["mathjax_question"] = value.encodeSpecialCharacters()
        }
        
        let trendingSearchDetails = ["trending_search": [dict2]]
       
        var realtimeSearchPageDictinary: [String: Any] = [:]
        realtimeSearchPageDictinary[Keys.trendingSearchSection] = trendingSearchDetails
        return realtimeSearchPageDictinary

    }

}

