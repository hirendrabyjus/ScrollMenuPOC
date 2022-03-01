//
//  ViewController.swift
//  AutoScrollMenu
//
//  Created by Hirendra Sharma on 21/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    private var menuViewModel: MenuViewModel = MenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPagerMenu()
    }
    
    func addPagerMenu() {
        let pager = PagerVC(pages: menuViewModel.getPages())
        pager.view.frame = containerView.bounds
        self.addChildVC(pager)
        containerView.addSubview(pager.view)
        pager.tabMenuBackgroundColor = UIColor.colorFromHex("#f6f6f6")
    }
}
