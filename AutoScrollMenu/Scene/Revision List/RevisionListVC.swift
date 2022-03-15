//
//  RevisionListVC.swift
//  AutoScrollMenu
//
//  Created by Hirendra Sharma on 08/03/22.
//

import UIKit
import SwiftUI

class RevisionListVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var revisionListViewModel = RevisonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWebView()
        //getRevisionAPI()
    }
    
    func getRevisionAPI() {
        revisionListViewModel.getDataForRevisions { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addWebView() {
        let webView = WebView(urlType: .localUrl, data: revisionListViewModel.revisionLists)
        webView.jsMessageHandler.delegate = self
        let hostingController = UIHostingController(rootView: webView)
        self.containerView.addToSelf(view: hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            containerView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        hostingController.didMove(toParent: self)
    }
    
}

extension RevisionListVC: JSHandlerProtocol {
    func revisionTapped(questionText: String, index: String?, qID: String?) {
        print(qID as Any)
    }
}

