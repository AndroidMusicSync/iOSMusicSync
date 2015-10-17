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
        signalCount = 0
        lastSignal = NSDate().timeIntervalSince1970
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Got sync
    func sync() {
        print("Sync")
    }

    //MARK: Microphone
    func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        fft.computeFFTWithBuffer(buffer[0], withBufferSize: bufferSize)
    }
    
    
    //MARK: fft
    func fft(fft: EZAudioFFT!, updatedWithFFTData fftData: UnsafeMutablePointer<Float>, bufferSize: vDSP_Length) {
        if signalCount < 3 && NSDate(timeIntervalSinceNow: -Double(SSKToneLength)).timeIntervalSince1970 > lastSignal && fft.maxFrequency > Float(SSKFrequency - 10) {
            signalCount++
            lastSignal = NSDate().timeIntervalSince1970
            if signalCount == 3 {
                sync()
            }
        }
    }
}
