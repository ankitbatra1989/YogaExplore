//
//  CustomTabBarController.swift
//  YogaExplore
//
//  Created by Ankit Batra on 08/01/21.
//

import UIKit

enum TabItem: String, CaseIterable {
    case yoga = "yoga"
    case chats = "chats"
    case articles = "articles"
    case settings = "settings"
    
    var viewController: UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
        case .yoga:
            return mainStoryboard.instantiateViewController(withIdentifier: "YogaNavigationController") as? UINavigationController ?? UINavigationController(rootViewController: YogaViewController())
        case .chats:
            return mainStoryboard.instantiateViewController(withIdentifier: "ChatsNavigationController") as? UINavigationController ?? UINavigationController(rootViewController: ChatsViewController())
        case .articles:
            return mainStoryboard.instantiateViewController(withIdentifier: "ArticlesNavigationController") as? UINavigationController ?? UINavigationController(rootViewController: ArticlesViewController())
        case .settings:
            return mainStoryboard.instantiateViewController(withIdentifier: "SettingsNavigationController") as? UINavigationController ?? UINavigationController(rootViewController: SettingsViewController())
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .yoga:
            return UIImage(named: "yoga")!
        case .chats:
            return UIImage(named: "chats")!
        case .articles:
            return UIImage(named: "articles")!
        case .settings:
            return UIImage(named: "settings")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
    
class CustomTabBarController: UITabBarController {
  
    var tabBarHeight: CGFloat = 90.0
    var customTabBar: CustomTabItemView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        delegate = self
    }
    
    private func loadTabBar() {
        let tabItems: [TabItem] = [.yoga, .chats, .articles, .settings]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        self.selectedIndex = 0
    }
    
    // Build the custom tab bar and hide default
    private func setupCustomTabBar(_ items: [TabItem], completion: @escaping ([UIViewController]) -> Void){
        let frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.x, width: tabBar.frame.width, height: tabBarHeight)
        var controllers = [UIViewController]()
        
        // hide the orignal tab bar
        tabBar.isHidden = true

        // Add positioning constraints to place the nav menu right where the tab bar should be
        self.customTabBar = CustomTabItemView(menuItems: items, frame: frame)
        self.customTabBar.backgroundColor = .white
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.layer.masksToBounds = false
        self.customTabBar.layer.cornerRadius = 45
        self.customTabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]

        self.customTabBar.layer.shadowColor = UIColor.black.cgColor
        self.customTabBar.layer.shadowOffset = CGSize(width: 5, height: -10)
        self.customTabBar.layer.shadowOpacity = 0.05
        self.customTabBar.layer.shadowPath = UIBezierPath(rect: customTabBar.bounds).cgPath
        self.customTabBar.layer.shadowRadius = 7.0
        self.customTabBar.itemTapped = self.changeTab

        // Add it to the view
        self.view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        self.view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
    
}

extension CustomTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTabTransition(viewControllers: tabBarController.viewControllers)
    }
}

class CustomTabTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.5

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view else {
                transitionContext.completeTransition(false)
                return
        }
        // initial state
        toView.alpha = 0.0
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.alpha = 0.0
                toView.alpha = 1.0
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

}
