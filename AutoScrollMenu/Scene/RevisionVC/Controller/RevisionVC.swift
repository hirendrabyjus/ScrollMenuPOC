//
//  RevisionVC.swift
//  AutoScrollMenu
//
//  Created by Hirendra Sharma on 21/02/22.
//

import UIKit
import SwiftUI

enum MenuType: Int {
    case quickBites = 0, summary, questions
}

class RevisionVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuHeigtConst: NSLayoutConstraint!
    private var menuViewModel: MenuViewModel = MenuViewModel()
    private var revisionListViewModel = RevisonListViewModel()
    var revisionWebView: WebViewController?
    var delegate: WebViewHandlerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPagerMenu()
        self.addContentView()
    }
    
    func addPagerMenu() {
        let pager = PagerVC(pages: menuViewModel.pages)
        pager.delegate = self
        pager.view.frame = menuView.bounds
        self.addChildVC(pager)
        menuView.addSubview(pager.view)
        
        pager.tabMenuBackgroundColor = UIColor.colorFromHex("#f6f6f6")
        menuHeigtConst.constant = pager.tabMenuHeight
    }
    
    func addContentView() {
        let contentVC = Storyboard.main.instantiateVC(ContentVC.self)
        contentVC.view.frame = containerView.bounds
        self.addChildVC(contentVC)
        containerView.addSubview(contentVC.view)
    }
    
    func addRevisionWebView() {
        if revisionWebView == nil {
            revisionWebView = WebViewController.instantiate(type: .localUrl, data: revisionListViewModel.revisionLists, htmlFileName: HtmlFileName.revisionList.fileName)
            
            guard let revisionWebView = revisionWebView else { return }
            
            revisionWebView.jsMessageHandler.delegate = self
            self.addChildVC(revisionWebView, containerView)
            revisionWebView.activateContainerViewConstraints(containerView)
        }
    }
    
    func refreshWebViewData(menuType: MenuType) {
        revisionWebView?.view.isHidden = false
        
        switch menuType {
        case .quickBites:
            revisionWebView?.view.isHidden = true
            
        case .summary:
            revisionWebView?.revisionData = revisionListViewModel.revisionLists
            revisionWebView?.htmlFileName = HtmlFileName.revisionList.fileName
            
        case .questions:
            revisionWebView?.revisionData = revisionListViewModel.revisionQuestions
            revisionWebView?.htmlFileName = HtmlFileName.revisionList.fileName
        }
        
        revisionWebView?.loadUrl()
    }
}

extension RevisionVC: SelectionMenuDelegate {

    func selectedMenuTab(selectedTab: Int) {
        guard let menuType: MenuType = MenuType(rawValue: selectedTab) else {
            return
        }
        self.addRevisionWebView()
        self.refreshWebViewData(menuType: menuType)
    }
}

extension RevisionVC: JSHandlerProtocol {
    
    func revisionTapped(questionText: String, index: String?, qID: String?) {
        print(qID as Any)
    }
}
