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
        addRevisionWebView()
        //getRevisionAPI()
    }
    
    func getRevisionAPI() {
        revisionListViewModel.getDataForRevisions { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addRevisionWebView() {
        let revisionWebView = WebViewController.instantiate(type: .localUrl, data: revisionListViewModel.revisionLists, htmlFileName: HtmlFileName.revisionList.fileName)
        revisionWebView.jsMessageHandler.delegate = self
        self.addChildVC(revisionWebView, containerView)
        revisionWebView.activateContainerViewConstraints(containerView)
    }
    
}

extension RevisionListVC: JSHandlerProtocol {
    
    func revisionTapped(questionText: String, index: String?, qID: String?) {
        print(qID as Any)
    }
}

