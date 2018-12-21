import UIKit

struct AnimationConst {
    static let animationYPoint = 100
    static let marginImageView = 16
}

class AnimationConscructHelper: NSObject {
    
    class func createFakeTextView(frame: CGRect, attrText: NSAttributedString)-> UITextView {
        let textView = UITextView(frame: frame)
        textView.alpha = 0
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.attributedText = attrText
        textView.backgroundColor = .white
        textView.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
        return textView
    }
    
    class func createSnapshot(frame: CGRect, cardImage: UIImage?)-> UIImageView {
        let snapshot = UIImageView(frame: frame)
        snapshot.image = cardImage
        snapshot.layer.cornerRadius = 14
        snapshot.layer.masksToBounds = true
        return snapshot
    }
    
}
