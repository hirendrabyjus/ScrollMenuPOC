
import UIKit
import SwiftUI

class ContentViewController: UIViewController {

    @IBOutlet weak var lableTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lableTitle.text = self.title
        addSwiftUIView()
    }
    
    func addSwiftUIView() {
        let swiftUIView = StackView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
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
