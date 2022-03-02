//
//  JSHandler.swift
//  stackview
//
//  Created by Pannaga Bhushana on 21/02/22.
//

import Foundation
import WebKit

enum RevisionPagePageJSFunctions: String, JavascriptFuntionConvertible {
    case displayTrendingSearch
    var name: String { return rawValue }
}

enum RevisionPageWebEvent: String, CaseIterable, JSEvent {
    case realtimeSearchQuestionTapped
    var name: String {
        return self.rawValue
    }
}

protocol JSHandlerProtocol: AnyObject{
    func bookMarkTapped()
}

class JSHandler: NSObject, WKScriptMessageHandler {
    
    var delegate: JSHandlerProtocol?
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
