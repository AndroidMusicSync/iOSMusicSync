//
//  PlayerManager.swift
//  SpeackerSync
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//  Easy handling of playing songs through the whole app
//

import Foundation

class PlayerManager {
    
    static let sharedPlayerManager = PlayerManager()
    private var player:AVAudioPlayer?
    
    init() {
        
    }
    
    func play(audioFile:NSURL) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        }
        catch {
        }
        if let player = player {
            player.stop()
        }
        do {
            try player = AVAudioPlayer(contentsOfURL: audioFile)
        }
        catch {
            
        }
        
        if let player = player {
            player.prepareToPlay()
            player.play()
        }
    }
    
    func stop() {
        if let player = player {
            player.stop()
        }
    }
}