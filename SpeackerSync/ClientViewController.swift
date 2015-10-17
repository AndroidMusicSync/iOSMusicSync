//
//  ClientViewController.swift
//  SpeackerSync
//
//  Created by Alex on 17/10/15.
//  Copyright © 2015 Alex Steiner. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController, EZMicrophoneDelegate, EZAudioFFTDelegate {

    //MARK: Actions
    
    
    //MARK: Outlets
    var microphone:EZMicrophone!
    var fft:EZAudioFFTRolling!
    var signalCount = 0
    var lastSignal = NSDate().timeIntervalSince1970
    var halo = PulsingHaloLayer(repeatCount: 0) {
        didSet {
            halo.radius = 200
            halo.backgroundColor = UIColor.whiteColor().CGColor
            halo.position = self.view.center
            self.view.layer.addSublayer(halo)
        }
    }
    
    //MARK: Attributes
    
    
    //MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setActive(true)
        }
        catch {
        }
        
        microphone = EZMicrophone(delegate: self)
        
        fft = EZAudioFFTRolling(windowSize: 4096, sampleRate: Float(microphone.audioStreamBasicDescription().mSampleRate), delegate: self)
        
        microphone.startFetchingAudio()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        resetCache()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        PlayerManager.sharedPlayerManager.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func resetCache() {
        signalCount = 0
        lastSignal = NSDate().timeIntervalSince1970
    }
    
    //MARK: Got sync
    func syncDone() {
        let path = NSBundle.mainBundle().pathForResource("jugendhackt", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        PlayerManager.sharedPlayerManager.play(url)
        resetCache()
    }
    
    func sync() {
        NSTimer.scheduledTimerWithTimeInterval(SSKToneLength + 1.25, target: self, selector: "syncDone", userInfo: nil, repeats: false)
    }

    //MARK: Microphone
    func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        fft.computeFFTWithBuffer(buffer[0], withBufferSize: bufferSize)
    }
    
    
    //MARK: fft
    func fft(fft: EZAudioFFT!, updatedWithFFTData fftData: UnsafeMutablePointer<Float>, bufferSize: vDSP_Length) {
        if signalCount < 3 && NSDate(timeIntervalSinceNow: -Double(SSKToneLength)).timeIntervalSince1970 > lastSignal && fft.maxFrequency > Float(SSKFrequency - 10) && fft.maxFrequency < Float(SSKFrequency + 10) {
        
            dispatch_async(dispatch_get_main_queue(), {
                self.halo = PulsingHaloLayer(repeatCount: 2)
            })
            
            signalCount++
            lastSignal = NSDate().timeIntervalSince1970
            print(signalCount)
            if signalCount == 3 {
                dispatch_async(dispatch_get_main_queue(), {
                    self.sync()
                })
            }
        }
    }
}
