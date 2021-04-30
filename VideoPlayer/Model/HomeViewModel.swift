//
//  HomeViewModel.swift
//  VideoPlayer
//
//  Created by jatin verma on 29/04/21.
//

import Foundation
import AVFoundation

class HomeViewModel: NSObject {
    
    private(set) var currentVideoIndex = 0
    private var docs = [String]()

    override init() {
        super.init()
        docs = ["https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476056/OnBoardingScreens/launch_onboarding_1.mp4", "https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476055/OnBoardingScreens/launch_onboarding_2.mp4", "https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476055/OnBoardingScreens/launch_onboarding_3.mp4", "https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476056/OnBoardingScreens/launch_onboarding_4.mp4"]
    }
    
    func setAudioMode() {
        do {
            try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch (let err){
            print("setAudioMode error:" + err.localizedDescription)
        }
        
    }
    
}
