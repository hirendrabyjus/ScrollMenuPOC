//
//  RevisionVC.swift
//  AutoScrollMenu
//
//  Created by Hirendra Sharma on 21/02/22.
//

import UIKit

class RevisionVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuHeigtConst: NSLayoutConstraint!
    private var menuViewModel: MenuViewModel = MenuViewModel()

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
    
}

extension RevisionVC: SelectionMenuDelegate {
    func selectedMenuTab(selectedTab: Int) {
        print(selectedTab)
    }
}
