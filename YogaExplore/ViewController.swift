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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
