//
//  ViewController.swift
//  SpeackerSync
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var iconImage: UIImageView! {
        didSet {
            iconImage.layer.cornerRadius = 6
            iconImage.layer.masksToBounds = true
            iconImage.layer.borderWidth = 2
            iconImage.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }
    
    //MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

