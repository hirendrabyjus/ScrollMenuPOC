
import UIKit

protocol SelectionMenuDelegate: AnyObject {
    func selectedMenuTab(selectedTab: Int)
}

public class PagerVC: UIViewController {
    
    @IBOutlet weak fileprivate var tabsMenuView: UIView!
    @IBOutlet weak fileprivate var containerScrollView: UIScrollView!
    @IBOutlet weak fileprivate var tabsCollectionView: UICollectionView!
    @IBOutlet weak fileprivate var tabsMenuHeightConstraint: NSLayoutConstraint!
    weak var delegate: SelectionMenuDelegate?
    
    open var tabMenuHeight: CGFloat = 44 {
        didSet {
            if let heightConstraint = tabsMenuHeightConstraint {
                heightConstraint.constant = tabMenuHeight
                reload()
            }
        }
    }
    
    open var tabMenuBackgroundColor: UIColor = UIColor.gray.withAlphaComponent(0.3) {
        didSet {
            reload()
        }
    }
    
    open var tabTitleColor: UIColor = UIColor.colorFromHex("#8f8f8f") {
        didSet {
            reload()
        }
    }
    
    open var tabTitleFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            reload()
        }
    }
    
    open var selectedTabTitleColor: UIColor = UIColor.white {
        didSet {
            reload()
        }
    }
    
    open var selectedTabTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 14) {
        didSet {
            reload()
        }
    }
    
    //MARK: - Private properties
    private var currentPage: Int = 0
    private var pages = [String]()
    
    /// Default initializer with pages
    public init(pages aPages: [String]) {
        super.init(nibName: "PagerVC", bundle: Bundle(for: PagerVC.self))
        pages = aPages
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupContents()
        tabsCollectionView.registerCell(PagerMenuCell.self)
        tabsCollectionView.registerNib(PagerMenuCell.self)
    }
    
    func setupContents() {
        containerScrollView.isScrollEnabled = true
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tabsCollectionView.backgroundColor = self.tabMenuBackgroundColor
            self.tabsCollectionView.reloadData()
            self.updateContentFrames()
        }
    }
    
    func updateContentFrames() {
        let containerScrollViewSize = containerScrollView.frame.size
        let contentScrollWidth = containerScrollViewSize.width * CGFloat(pages.count)
        containerScrollView.contentSize = CGSize(width: contentScrollWidth, height: containerScrollViewSize.height)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateContentFrames()
    }
    
    func getTitleWidth(title: String, font: UIFont) ->CGFloat {
        let label = UILabel()
        label.font = font
        label.text = title
        label.numberOfLines = 1
        label.sizeToFit()
        return label.frame.width + (label.frame.width * 0.3) + 30
    }
}

extension PagerVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(PagerMenuCell.self, indexPath: indexPath)
        cell.tabNameLabel.font = tabTitleFont
        cell.tabNameLabel.backgroundColor = .clear
        cell.tabNameLabel.textColor = tabTitleColor
        cell.tabNameLabel.text = pages[indexPath.row]
        
        if indexPath.row == currentPage {
            cell.tabNameLabel.textColor = selectedTabTitleColor
            cell.tabNameLabel.font = selectedTabTitleFont
            cell.tabNameLabel.layer.cornerRadius = cell.tabNameLabel.frame.size.height/2
            cell.tabNameLabel.layer.masksToBounds = true
            cell.tabNameLabel.backgroundColor = UIColor.colorFromHex("#ffb700")
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == currentPage {
            let width = getTitleWidth(title: pages[indexPath.row], font: selectedTabTitleFont)
            return CGSize(width: width, height: tabMenuHeight)
        }
        let width = getTitleWidth(title: pages[indexPath.row], font: tabTitleFont)
        return CGSize(width: width, height: tabMenuHeight)
    }
}

extension PagerVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollContent(to: indexPath.row)
    }
}

extension PagerVC: UIScrollViewDelegate {
    
    fileprivate func scrollContent(to page: Int) {
        currentPage = page
        let containerWidth = containerScrollView.frame.size.width
        let containerHeight = containerScrollView.frame.size.height
        let contentFrameToScroll = CGRect(x: containerWidth*CGFloat(page), y: 0, width: containerWidth, height: containerHeight)
        containerScrollView.scrollRectToVisible(contentFrameToScroll, animated: true)
        scrollTabMenu(to: page)
    }
    
    fileprivate func scrollTabMenu(to selectedTab: Int) {
        let menuIndexPathToScroll = IndexPath(row: selectedTab, section: 0)
        tabsCollectionView.scrollToItem(at: menuIndexPathToScroll, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        tabsCollectionView.reloadData()
        self.delegate?.selectedMenuTab(selectedTab: selectedTab)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == containerScrollView {
            let page: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
            scrollContent(to: page)
        }
    }
}
