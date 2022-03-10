//
//  JSHandler.swift
//  stackview
//
//  Created by Pannaga Bhushana on 21/02/22.
//

import Foundation
import WebKit

enum RevisionPagePageJSFunctions: String, JavascriptFuntionConvertible {
    case displayRevisions
    var name: String { return rawValue }
}

enum RevisionPageWebEvent: String, CaseIterable, JSEvent {
    case revisionTapped
    var name: String {
        return self.rawValue
    }
}

protocol JSHandlerProtocol: AnyObject {
    func bookMarkTapped()
    func revisionTapped(questionText: String, index: String?, qID: String?)
}

extension JSHandlerProtocol {
    func bookMarkTapped() {}
    func revisionTapped(questionText: String, index: String?, qID: String?) {}
}

class JSHandler: NSObject, WKScriptMessageHandler {
    
    var delegate: JSHandlerProtocol?
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let event = RevisionPageWebEvent(rawValue: message.name) else {
            print("\(message.name) == \(message.body)")
            return
        }
        
        switch event {
        case .revisionTapped:
            guard let json = RevisionResponse(message: message.body) else { return }
            delegate?.revisionTapped(questionText: json.questionText,index: json.index, qID: json.qid)
        }
    }
    
    public struct RevisionResponse {
        struct Keys {
            static let question = "question"
            static let index = "index"
            static let qid = "qid"
        }
        private(set) var questionText: String = ""
        private(set) var index: String?
        private(set) var qid: String?
        
        public init?(message: Any) {
            if let jsonText = message as? [String : Any] {
                questionText = jsonText[Keys.question] as? String ?? ""
                index = "\(jsonText[Keys.index] ?? "")"
                qid = jsonText[Keys.qid] as? String ?? ""
            }
        }
    }
    
}
