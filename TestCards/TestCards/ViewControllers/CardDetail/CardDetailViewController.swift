

import UIKit

class CardDetailViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: StyledLabel!
    @IBOutlet weak var textView: UITextView!
    
    var descriptionText: String? {
        didSet {
            if let text = self.descriptionText {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 8
                let attributes = [NSAttributedString.Key.paragraphStyle : style,
                                  NSAttributedString.Key.foregroundColor: UIColor.gray,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)]
                self.textView.attributedText = NSAttributedString(string: "  " + text, attributes: attributes)
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    var imageFrame: CGRect {
        return self.imageView.frame
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureCardDetailNavigationBarStyle()
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = self.configureLeftBarButton()
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.hidesBackButton = true
    }
    
    private func configureUI() {
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .white
        self.scrollView.backgroundColor = .white
        self.headerView.backgroundColor = .white
        
        self.textView.isEditable = false
        self.textView.isScrollEnabled = false
        self.textView.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
    }
    
    internal func configureRoundedCorners(shouldRound: Bool) {
        self.imageView.layer.cornerRadius = shouldRound ? 14.0 : 0.0
        self.imageView.layer.masksToBounds = true
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc override func onBackButtonPressed(_ sender: Any) {
        self.dismiss()
    }
    
}
