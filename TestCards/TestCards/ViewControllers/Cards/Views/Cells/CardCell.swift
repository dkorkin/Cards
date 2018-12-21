import UIKit

internal class CardCell: BaseCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: StyledLabel!
    
    var viewModel: Card?
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath, viewModel: Card?) -> CardCell {
        guard let cell: CardCell = collectionView.dequeueReusableCell(indexPath: indexPath) else {
            fatalError("*** Failed to dequeue CardCell ***")
        }
        cell.viewModel = viewModel
        cell.labelTitle.text = viewModel?.title
        cell.imageView.image = UIImage(named: viewModel?.imageName ?? "")
        cell.imageView.isHidden = false
        cell.labelTitle.isHidden = false
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 14.0
    }

}
