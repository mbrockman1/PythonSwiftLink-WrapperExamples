//
//  AVPlayerApi.swift
//  apple_api
//
//  Created by MusicMaker on 03/03/2022.
//

import Foundation
import UIKit
import AVFoundation

class AVPlayerApi: NSObject {
    var audioplayer = AVAudioPlayer()
    override init() {
        super.init()
        InitAVPlayerApi_Delegate(delegate: self)
    }
}

extension AVPlayerApi: AVPlayerApi_Delegate {
    func rate_adjustment(adjuster: Double) {
        self.audioplayer.pause()
        let new_rate = self.audioplayer.rate + Float(adjuster)
        self.audioplayer.rate = Float(new_rate)
        self.audioplayer.prepareToPlay()
        self.audioplayer.play()
    }
    
    func player_status() -> Bool{
        return(self.audioplayer.isPlaying)
    }

    func play(filePath: String) {
        do{
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback
            )

            try AVAudioSession.sharedInstance().setActive(true)
            self.audioplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
            self.audioplayer.enableRate = true
        }
        catch{
            print(error)
        }
    }

    func rate_reset() {
        self.audioplayer.pause()
        self.audioplayer.rate = 1.0
        self.audioplayer.prepareToPlay()
        self.audioplayer.play()
    }
    
    func play_or_pause() {
        if self.audioplayer.isPlaying {
            self.audioplayer.pause()
        } else {
            self.audioplayer.play()
        }
    }
    
    func return_currentTime() -> Double{
        return(Double(self.audioplayer.currentTime))
    }
    
    func return_duration() -> Double{
        return(Double(self.audioplayer.duration))
    }
    
}
