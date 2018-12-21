import UIKit

class CardsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var lastOpened: CardViewModel?
    var cards: [Card]? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    var topDistance: CGFloat {
        get {
            if self.navigationController != nil && !self.navigationController!.navigationBar.isTranslucent {
                return 0
            } else {
                let height = self.topLayoutGuide.length
                return height
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cards"
        self.navigationController?.delegate = self
        self.configure(collectionView: self.collectionView)
        self.cards = ContentLoader.cards()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureCardsNavigationBarStyle()
    }

}

extension CardsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PresentAnimatedTransition()
        case .pop:
            return DismissAnimatedTransition()
        default:
            return PresentAnimatedTransition()
        }
    }
}

extension CardsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    internal func configure(collectionView: UICollectionView) {
        collectionView.registerReusableCell(CardCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let card = cards?[indexPath.row] else {
            return UICollectionViewCell()
        }
        return CardCell.dequeue(fromCollectionView: collectionView, atIndexPath: indexPath, viewModel: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: BaseCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
            let detailVC = CardDetailViewController()
            let imageFrame = cell.imageView.convert(cell.imageView.bounds, to: self.view)
            let labelFrame = cell.labelTitle.convert(cell.labelTitle.bounds, to: self.view)
            self.lastOpened = CardViewModel(card: self.cards?[indexPath.row], imageFrame: imageFrame, labelFrame: labelFrame)
            cell.imageView.isHidden = true
            cell.labelTitle.isHidden = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}





