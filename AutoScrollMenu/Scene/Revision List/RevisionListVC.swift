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
    var viewModel = ViewModel()
    private var data: Data!
    private var webView: WebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.webView = WebView(urlType: .localUrl, viewModel: viewModel, data: data)
        //self.containerView.addToSelf(view: self.webView)
        
        //addSwiftUIView()
    }
    
    func addSwiftUIView() {
        let swiftUIView = WebView(urlType: .localUrl, viewModel: viewModel, data: data)
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        self.containerView.addToSelf(view: hostingController.view)
        
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
                view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
            ]

            NSLayoutConstraint.activate(constraints)

            /// Notify the hosting controller that it has been moved to the current view controller.
            hostingController.didMove(toParent: self)
        
    }
    
}
