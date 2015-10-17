//
//  MasterViewController.swift
//  SpeackerSync
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBAction func sync(sender: AnyObject) {
        sync()
    }
    
    let wrapper = WaveToneGeneratorWrapper()
    var playNumber = 0
    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Done Sync
    func syncDone() {
        let path = NSBundle.mainBundle().pathForResource("simple-drum-beat", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        PlayerManager.sharedPlayerManager.play(url)
    }
    
    //MARK: Sync
    func sync() {
        playSound()
        timer = NSTimer.scheduledTimerWithTimeInterval(SSKToneLength + 1.5, target: self, selector: "playSound", userInfo: nil, repeats: true)
    }
    
    func playSound() {
        wrapper.playFrequency(SSKFrequency, onChannel: 0, forDuration: SSKToneLength)
        playNumber++
        if let timer = timer where playNumber > 2 {
            timer.invalidate()
            playNumber = 0
            NSTimer.scheduledTimerWithTimeInterval(SSKToneLength + 0.05, target: self, selector: "syncDone", userInfo: nil, repeats: false)
        }
    }

}
