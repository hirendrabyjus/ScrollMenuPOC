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
    var revisioWebViewVC: WebViewController?
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
        if revisioWebViewVC == nil {
            revisioWebViewVC = WebViewController.instantiate(type: .localUrl, data: revisionListViewModel.revisionLists, htmlFileName: HtmlFileName.revisionList.fileName)
            revisioWebViewVC?.jsMessageHandler.delegate = self
            self.containerView.addToSelf(view: revisioWebViewVC?.view)
        }
    }
    
    func refreshWebViewData(menuType: MenuType) {
        revisioWebViewVC?.view.isHidden = false
        
        switch menuType {
        case .quickBites:
            revisioWebViewVC?.revisionData = revisionListViewModel.revisionLists
            revisioWebViewVC?.htmlFileName = HtmlFileName.cardView.fileName
            revisioWebViewVC?.view.isHidden = true
            
        case .summary:
            revisioWebViewVC?.revisionData = revisionListViewModel.revisionLists
            revisioWebViewVC?.htmlFileName = HtmlFileName.revisionList.fileName
            
        case .questions:
            revisioWebViewVC?.revisionData = revisionListViewModel.revisionQuestions
            revisioWebViewVC?.htmlFileName = HtmlFileName.revisionList.fileName
        }
        
        revisioWebViewVC?.loadUrl()
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
