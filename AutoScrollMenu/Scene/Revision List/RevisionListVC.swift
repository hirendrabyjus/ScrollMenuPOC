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
    private var revisionListViewModel = RevisonListViewModel()
    
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
        let webView = WebView(urlType: .localUrl, data: revisionListViewModel.revisionLists, htmlFileName: HtmlFileName.revisionList.fileName)
        webView.jsMessageHandler.delegate = self
        let hostingController = UIHostingController(rootView: webView)
        self.containerView.addToSelf(view: hostingController.view)
        hostingController.activateConstraints(containerView: containerView)
        hostingController.didMove(toParent: self)
    }
    
}

extension RevisionListVC: JSHandlerProtocol {
    
    func revisionTapped(questionText: String, index: String?, qID: String?) {
        print(qID as Any)
    }
}

