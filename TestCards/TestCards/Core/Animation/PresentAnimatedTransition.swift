import UIKit

internal class PresentAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var selectedCardFrame: CGRect = .zero
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? CardsViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? CardDetailViewController,
            let originFrame = fromViewController.lastOpened?.imageFrame else {
            return
        }
        
        toViewController.imageView.isHidden = true
        toViewController.textView.isHidden = true
        toViewController.view.alpha = 0
        toViewController.view.frame = UIScreen.main.bounds
        containerView.frame =  fromViewController.view.frame
        toViewController.descriptionText = fromViewController.lastOpened?.card?.content
        toViewController.labelTitle.text = fromViewController.lastOpened?.card?.title
        
        let textFrame = fromViewController.lastOpened?.imageFrame ?? .zero
        let textView = AnimationConscructHelper.createFakeTextView(frame: textFrame, attrText: toViewController.textView.attributedText)
    
        var snapshot = UIImageView()
        if let card = fromViewController.lastOpened?.card {
            let image = UIImage.init(named: card.imageName)
            snapshot = AnimationConscructHelper.createSnapshot(frame: originFrame, cardImage: image)
        }
        let startPoint = snapshot.frame.origin

        toViewController.labelTitle.alpha = 0
        let labelTitle = StyledLabel(frame: fromViewController.lastOpened?.labelFrame ?? .zero)
        labelTitle.text = fromViewController.lastOpened?.card?.title
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(textView)
        containerView.addSubview(snapshot)
        containerView.addSubview(labelTitle)
 
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
            //5% of duration
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: duration * 0.03) {
                if startPoint.y < 100 {
                    snapshot.frame.origin = CGPoint(x: startPoint.x, y: startPoint.y - 16)
                }
                else {
                    snapshot.frame.origin = CGPoint(x: startPoint.x, y: startPoint.y + 16)
                }
            }
            //45% of duration
            UIView.addKeyframe(withRelativeStartTime: duration * 0.04, relativeDuration: duration * 0.46) {
                snapshot.frame = CGRect(origin: CGPoint(x: 16, y: 100), size: snapshot.bounds.size)
                textView.frame = snapshot.frame
                labelTitle.frame = CGRect(origin: CGPoint(x: 36, y: snapshot.frame.maxY - labelTitle.frame.height - 20), size: fromViewController.lastOpened?.labelFrame?.size ?? .zero)
            }
            //50% of duration
            UIView.addKeyframe(withRelativeStartTime: duration * 0.5, relativeDuration: duration * 0.5) {
                snapshot.frame = toViewController.imageFrame
                textView.alpha = 1
                textView.frame = toViewController.textView.frame
                labelTitle.frame = CGRect(origin: CGPoint(x: 36, y: toViewController.imageFrame.maxY - labelTitle.frame.height - 20), size: fromViewController.lastOpened?.labelFrame?.size ?? .zero)
                snapshot.layer.cornerRadius = 0
                snapshot.layer.masksToBounds = true
                toViewController.view.alpha = 1
                toViewController.labelTitle.alpha = 1
                toViewController.configureRoundedCorners(shouldRound: false)
            }
        }, completion: { success in
            if success {
                snapshot.isHidden = true
                labelTitle.isHidden = true
                textView.isHidden = true
                toViewController.textView.isHidden = false
                toViewController.imageView.image = snapshot.image
                toViewController.imageView.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

}
