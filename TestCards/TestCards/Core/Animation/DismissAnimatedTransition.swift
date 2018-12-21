import UIKit

internal class DismissAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    internal var selectedCardFrame: CGRect = .zero
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? CardDetailViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? CardsViewController else {
            return
        }
        toViewController.view.isHidden = true
        let finishPoint = toViewController.lastOpened?.imageFrame?.origin
        
        let textView = AnimationConscructHelper.createFakeTextView(frame: fromViewController.textView.frame, attrText: fromViewController.textView.attributedText)
        
        fromViewController.textView.isHidden = true
        
        let snapshot = AnimationConscructHelper.createSnapshot(frame: fromViewController.imageView.frame, cardImage: fromViewController.imageView.image)
        fromViewController.imageView.isHidden = true
        
        let labelTitle = StyledLabel(frame: fromViewController.labelTitle.frame)
        labelTitle.text = fromViewController.labelTitle.text

        toViewController.view.alpha = 0
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(textView)
        containerView.addSubview(snapshot)
        containerView.addSubview(labelTitle)
        
        // 3
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            //50% of duration
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: duration * 0.5) {
                toViewController.view.alpha = 1
                snapshot.frame = CGRect(origin: CGPoint(x: AnimationConst.marginImageView,
                                                        y: AnimationConst.animationYPoint),
                                        size: toViewController.lastOpened?.imageFrame?.size ?? .zero)
                textView.frame = snapshot.frame
                textView.alpha = 0
                labelTitle.frame = CGRect(origin: CGPoint(x: 32, y: snapshot.frame.maxY - labelTitle.frame.height - 16), size: toViewController.lastOpened?.labelFrame?.size ?? .zero)
            }
            
            //45% of duration
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.46) {
                toViewController.view.isHidden = false
                snapshot.layer.cornerRadius = 14
                snapshot.layer.masksToBounds = true
                if let finishPoint = finishPoint {
                    if finishPoint.y < 100 {
                        snapshot.frame = CGRect(origin: CGPoint(x: finishPoint.x, y: finishPoint.y - 16), size: snapshot.frame.size)
                    }
                    else {
                        snapshot.frame = CGRect(origin: CGPoint(x: finishPoint.x, y: finishPoint.y + 20), size: snapshot.frame.size)
                    }
                }
                labelTitle.frame = toViewController.lastOpened?.labelFrame ?? .zero
            }
            
            //5% of duration
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: duration * 0.04) {
                snapshot.frame = toViewController.lastOpened?.imageFrame ?? .zero
            }
        }, completion: { success in
            if success {
                snapshot.isHidden = true
                labelTitle.isHidden = true
                toViewController.collectionView.reloadData()
                toViewController.configureCardsNavigationBarStyle()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
}
