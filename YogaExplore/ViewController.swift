//
//  ViewController.swift
//  YogaExplore
//
//  Created by Ankit Batra on 08/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = (startButton.bounds.size.height/2)
        startButton.layer.shadowColor = UIColor(red: (185.0/255.0), green: (160.0/255.0), blue: (137.0/255.0), alpha: 1.0).cgColor
        startButton.layer.shadowOffset = CGSize(width: 5, height: 10)
        startButton.layer.shadowOpacity = 0.2
        startButton.layer.shadowPath = UIBezierPath(rect: startButton.bounds).cgPath
        startButton.layer.shadowRadius = 5.0
        startButton.layer.masksToBounds = false
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomNavigationTransition(originFrame: self.view.frame)
    }
}

class CustomNavigationTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let transitionDuration: Double = 5.5
    private let originFrame: CGRect

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewController,
            let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let tabbarController = toVC as? CustomTabBarController
        if let toVc = (tabbarController?.viewControllers?.first as? UINavigationController)?.viewControllers.first as? YogaViewController {
            let toView = UIView(frame: toVC.view.frame)
            toView.addSubview(UIView(frame: CGRect(x: 0, y: 0, width: toVc.view.bounds.size.width, height: 380.0)))
            if let snapshotView = toVc.view.snapshotView(afterScreenUpdates: false) {
                toView.addSubview(snapshotView)
            }
            let containerView = transitionContext.containerView
            let startButtonFrame = containerView.convert(
                fromVC.startButton.frame,
                from: fromVC.startButton.superview
            )
            let startView =  UIView()
            startView.frame = startButtonFrame
        
            // Adding the subviews to the container view.
            containerView.addSubview(fromVC.view)
            containerView.addSubview(toVC.view)
            containerView.addSubview(toView)
            containerView.addSubview(startView)
        
            // Hidding/Showing objects to not/be displayed while animating the transition.
            fromVC.view.isHidden = false
            toVC.view.isHidden = true
            

            // Animate the view objects using PropertyAnimator
            let animator1 = {
                UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
                    startView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                }
            }()

            let animator2 = {
                UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
                    toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }
            }()

            // Prepare the animations sequence
            animator1.addCompletion { _ in
                animator2.startAnimation()
            }

            animator2.addCompletion { _ in
                fromVC.view.isHidden = true
                toVC.view.isHidden = false
                toView.removeFromSuperview()
                startView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }

            // Run animations
            animator1.startAnimation()
        } else {
            transitionContext.completeTransition(true)
        }
    }

}
