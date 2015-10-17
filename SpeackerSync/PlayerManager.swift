//
//  PlayerManager.swift
//  SpeackerSync
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//

import Foundation

class PlayerManager {
    
    static let sharedPlayerManager = PlayerManager()
    private var player:AVAudioPlayer?
    
    init() {
    }
    
    func play(audioFile:NSURL) {
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