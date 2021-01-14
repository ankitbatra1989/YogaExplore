//
//  YogaViewController.swift
//  YogaExplore
//
//  Created by Ankit Batra on 11/01/21.
//

import UIKit

class YogaViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var ratingViewheightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageBottomContraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        backgroundImageView.layer.cornerRadius = 40
        backgroundImageView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        backgroundImageView.layer.masksToBounds = true
        //
        ratingView.layer.masksToBounds = false
        ratingView.layer.shadowColor = UIColor(red: (185.0/255.0), green: (160.0/255.0), blue: (137.0/255.0), alpha: 1.0).cgColor
        ratingView.layer.shadowOffset = CGSize(width: 5, height: 10)
        ratingView.layer.shadowOpacity = 0.2
        ratingView.layer.shadowPath = UIBezierPath(rect: ratingView.bounds).cgPath
        ratingView.layer.shadowRadius = 5.0
        //
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0.0, y: 0.0 , width: view.bounds.size.width, height: 83)
        layer.colors = [UIColor(red: (180.0/255.0), green: (180.0/255.0), blue: (180.0/255.0), alpha:1.0).cgColor, UIColor(red: (205.0/255.0), green: (205.0/255.0), blue: (205.0/255.0), alpha:0.1).cgColor]
        backgroundImageView.layer.addSublayer(layer)
        //
        self.scrollView.alpha = 0
        self.imageContainerView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.alpha = 1
        }
        UIView.animate(withDuration: 0.5) {
            self.imageContainerView.alpha = 1
        }
        self.imageBottomContraint.constant = 0
        self.leadingConstraint.constant = 40
        self.leftConstraint.constant = 40
        UIView.animate(withDuration: 0.5, animations: {
            self.imageContainerView.layoutIfNeeded()
        }, completion: { (completed) in
            if completed {
                self.ratingView.layer.masksToBounds = false
                self.ratingView.layer.shadowColor = UIColor(red: (185.0/255.0), green: (160.0/255.0), blue: (137.0/255.0), alpha: 1.0).cgColor
                self.ratingView.layer.shadowOffset = CGSize(width: 5, height: 10)
                self.ratingView.layer.shadowOpacity = 0.2
                self.ratingView.layer.shadowPath = UIBezierPath(rect: self.ratingView.bounds).cgPath
                self.ratingView.layer.shadowRadius = 5.0
            }
        })
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.imageBottomContraint.constant = 250
        self.leadingConstraint.constant = 70
        self.leftConstraint.constant = 70
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.alpha = 0
            self.imageContainerView.layoutIfNeeded()
        }, completion: { (completed) in
            self.tabBarController?.navigationController?.popToRootViewController(animated: false)
        })
        
    }
    
    @IBAction func starTapped(_ sender: UIButton) {
        // Set rating label
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        // set favourite/ unfavourite
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        // location button tapped. Open maps
    }
    
    @IBAction func seeOnMapButtonTapped(_ sender: UIButton) {
        // Show location on map 
    }

    @IBAction func addReviewButtonTapped(_ sender: UIButton) {
        // Add review button tapped
    }
}
