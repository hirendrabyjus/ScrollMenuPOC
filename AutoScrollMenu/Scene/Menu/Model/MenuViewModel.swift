
import Foundation
import UIKit

class MenuViewModel {
    
    let pages = ["Quick Bites","Summary","Questions","Quick Bites","Summary","Questions"]

    func getPages() -> [UIViewController] {
        var pageArray: [UIViewController] = [UIViewController]()
        for pageName in pages {
            let page = Storyboard.main.instantiateVC(ContentViewController.self)
            page.title = pageName
            pageArray.append(page)
        }
        return pageArray
    }
    
}
