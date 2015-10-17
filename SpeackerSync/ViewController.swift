//
//  ViewController.swift
//  SpeackerSync
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func sync(sender: AnyObject) {
        sync()
    }
    
    let wrapper = WaveToneGeneratorWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sync() {
        wrapper.playFrequency(SSKFrequency, onChannel: 0, forDuration: 2)
    }


}

