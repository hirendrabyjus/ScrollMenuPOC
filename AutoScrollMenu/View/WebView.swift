
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

protocol WebViewHandlerDelegate {
    func didDataChange(data: [RevisionData])
}

struct WebView: UIViewControllerRepresentable{
    
    
    typealias UIViewControllerType = WebViewController
   
    var urlType: WebUrl
    var viewModel = ViewModel()
    var data: [RevisionData]
    var jsMessageHandler = JSHandler()
    var htmlFileName: String
    var revisionVC: RevisionVC?
    
    func makeUIViewController(context: Context) -> WebViewController {
        WebViewController.instantiate(type: urlType, data: data, htmlFileName: HtmlFileName.cardView.fileName)
    }

        func updateUIViewController(_ viewController: WebViewController,
                                    context: Context) {
            // Nothing to do here, since our view controller is
            // read-only from the outside.
        }
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//
//    }
    
  //  func makeUIView(context: Context) -> WKWebView {
        

//        let webView = WKWebView(frame: CGRect.zero, configuration: jsMessageHandler.webViewConfiguration)
//        webView.navigationDelegate = context.coordinator
//        webView.allowsBackForwardNavigationGestures = true
//
//        if data.first?.type == "RevisionList" {
//            webView.scrollView.isScrollEnabled = true
//        } else {
//            webView.scrollView.isScrollEnabled = false
//        }
//        webView.backgroundColor = .clear
//        context.coordinator.webView = webView
//        return webView
   // }
    
    //func updateUIView(_ webView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
//        if urlType == .localUrl {
//            // Load local website
//            if let url = Bundle.main.url(forResource: htmlFileName, withExtension: "html") {
//                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
//            }
//        }
   // }
    
//    func refreshData() {
//
//    }
    
//    class Coordinator: NSObject, WKNavigationDelegate,WebViewHandlerDelegate {
//        var parent: WebView
//        var valueSubscriber: AnyCancellable? = nil
//        var webViewNavigationSubscriber: AnyCancellable? = nil
//        var webView: WKWebView?
//
//        init(_ uiWebView: WebView) {
//            self.parent = uiWebView
//            super.init()
//            parent.revisionVC?.delegate = self
//        }
//
//
//        deinit {
//            valueSubscriber?.cancel()
//            webViewNavigationSubscriber?.cancel()
//            self.parent.jsMessageHandler.cleanUp()
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            // Page loaded so no need to show loader anymore
//            let param = loadParamsInToWebView()
//            let test = "displayRevisions"
//            let paramString = "\(test)(" + "'\(encodeDictionary(param)!)'" + ")"
//            webView.evaluateJavaScript(paramString) { (response, error) in
//                if let error = error {
//                    print("Error getting title")
//                    print(error.localizedDescription)
//                }
//
//                guard let title = response as? String else {
//                    return
//                }
//            }
//        }
//
//        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
//
//        }
//
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            parent.viewModel.showLoader.send(false)
//        }
//
//        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//            parent.viewModel.showLoader.send(true)
//        }
//
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            parent.viewModel.showLoader.send(true)
//            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
//                switch navigation {
//                case .backward:
//                    if webView.canGoBack {
//                        webView.goBack()
//                    }
//                case .forward:
//                    if webView.canGoForward {
//                        webView.goForward()
//                    }
//                }
//            })
//        }
//
//        // This function is essential for intercepting every navigation in the webview
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//            // Suppose you don't want your user to go a restricted site
//            if let host = navigationAction.request.url?.host {
//                if host == "restricted.com" {
//                    // Navigation is cancelled
//                    decisionHandler(.cancel)
//                    return
//                }
//            }
//            decisionHandler(.allow)
//        }
//    }
//}
//
//extension WebView.Coordinator{
//    func didDataChange(data: [RevisionData]) {
//        parent.data = data
//        webView?.reload()
//    }
//
//
//    func encodeDictionary(_ dictionary: [String: Any]) -> String? {
//        guard let theJSONData = try? JSONSerialization.data(
//            withJSONObject: dictionary,
//            options: []) else {
//                return ""
//            }
//        let base64Encoded = theJSONData.base64EncodedString()
//        return base64Encoded
//    }
//
//    private func loadParamsInToWebView() -> [String : Any] {
//        struct Keys {
//            static let revisionSection = "revisionSection"
//        }
//
//        var revisionDetails: [Any] = [Any]()
//        for obj in self.parent.data {
//            var dict = ["type": obj.type ?? "",
//                        "qid": "\(obj.id)",
//                        "mathjax_question": obj.mathjaxContent,
//            ] as [String : Any]
//
//            if let value = dict["mathjax_question"] as? String {
//                dict["mathjax_question"] = value.encodeSpecialCharacters()
//            }
//            revisionDetails.append(dict)
//        }
//
//        let revisions = ["trending_search": revisionDetails]
//
//        var revisionsDictinary: [String: Any] = [:]
//        revisionsDictinary[Keys.revisionSection] = revisions
//        return revisionsDictinary
//    }
//}
}
