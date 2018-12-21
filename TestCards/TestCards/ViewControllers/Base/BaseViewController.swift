import UIKit

class BaseViewController: UIViewController {
    
    func configureCardsNavigationBarStyle() {
        let color = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.from(color: color), for: UIBarMetrics.default)
    }
    
    func configureCardDetailNavigationBarStyle() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
    }
    
}

extension BaseViewController {
    
    func configureLeftBarButton() -> UIBarButtonItem {
        let containerView =  UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        blurEffectView.center = containerView.center
        blurEffectView.rounded()
        
        let backButton = self.configureBackButton()
        containerView.addSubview(blurEffectView)
        containerView.addSubview(backButton)
        let barButtonItem = UIBarButtonItem()
        barButtonItem.customView = containerView
        return barButtonItem
    }
    
    private func configureBackButton() -> UIButton {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "navbar_back"), for: .normal)
        backButton.tintColor = .white
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backButton.addTarget(self, action: #selector(self.onBackButtonPressed(_:)), for: .touchUpInside)
        backButton.isExclusiveTouch = true
        return backButton
    }
    
    @objc func onBackButtonPressed(_ sender: Any) {}
}
