//
//  PlaySoundsViewController.swift
//  PitchPerfectSH
//
//  Created by SH MAC on 2017. 1. 11..
//  Copyright © 2017년 udacity. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var chipmukButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var slVolume: UISlider!
    
    
     let MAX_VOLUME: Float = 10.0
    var recordedAudioURL : URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var audioPlayer: AVAudioPlayer!
   // var wrapperView = UIView(frame: CGRect(x:30,y:30,width:50,height:20))
   
    
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
  
        switch(ButtonType(rawValue: sender.tag)!) {
        
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }
    
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        //print("stop button pressed")
        stopAudio()
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
    
        audioPlayer.volume = slVolume.value
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
      


        // Do any additional setup after loading the view.
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
