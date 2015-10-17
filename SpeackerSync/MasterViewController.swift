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
        if !isPlaying {
            sync()
        }
    }
    
    let wrapper = WaveToneGeneratorWrapper()
    var playNumber = 0
    var timer:NSTimer?
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        PlayerManager.sharedPlayerManager.stop()
    }
    
    //MARK: Done Sync
    func syncDone() {
        let path = NSBundle.mainBundle().pathForResource("simple-drum-beat", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        PlayerManager.sharedPlayerManager.play(url)
        isPlaying = false
    }
    
    //MARK: Sync
    func sync() {
        isPlaying = true
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
