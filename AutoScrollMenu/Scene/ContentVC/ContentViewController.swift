
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
        hostingController.rootView.viewAllButtonPressed = {
            let revisonList = Storyboard.main.instantiateVC(RevisionListVC.self)
            self.navigationController?.pushViewController(revisonList, animated: false)
        }
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
            hostingController.didMove(toParent: self)
    }
}
