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
    @IBOutlet weak var backgroundImageHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImageView.layer.cornerRadius = 40
        backgroundImageView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        backgroundImageView.layer.masksToBounds = true

        ratingView.layer.masksToBounds = false
        ratingView.layer.shadowColor = UIColor(red: (185.0/255.0), green: (160.0/255.0), blue: (137.0/255.0), alpha: 1.0).cgColor
        ratingView.layer.shadowOffset = CGSize(width: 5, height: 10)
        ratingView.layer.shadowOpacity = 0.2
        ratingView.layer.shadowPath = UIBezierPath(rect: ratingView.bounds).cgPath
        ratingView.layer.shadowRadius = 5.0
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func starTapped(_ sender: UIButton) {
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func seeOnMapButtonTapped(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
