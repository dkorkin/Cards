

import UIKit

internal class BaseCell: UICollectionViewCell {
    
    internal static let cellHeight: CGFloat = 300
    private static let kInnerMargin: CGFloat = 16
    
    private weak var shadowView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }
    
    private func configureShadow() {
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: BaseCell.kInnerMargin,
                                              y: BaseCell.kInnerMargin,
                                              width: bounds.width - (2 * BaseCell.kInnerMargin),
                                              height: bounds.height - (2 * BaseCell.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.35
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }
    
}

