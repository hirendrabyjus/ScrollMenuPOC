
import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var lableTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lableTitle.text = self.title
    }
}
