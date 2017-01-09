//
//  RecordSoundsViewController.swift
//  20170103
//
//  Created by SH MAC on 2017. 1. 3..
//  Copyright © 2017년 udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    var audioRecorder:AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!// 이런 ibOutlet이 상태바뀌는거와 관련있는듯
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {// 뷰컨트롤러의 뷰가 메모리에 로드된 이후에 호출됨
        super.viewDidLoad()
        print("ssss나니?")
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {//뷰 컨트롤러에 뷰가 뷰 계층에 추가 될 예정임을 알립니다.
        super.viewWillAppear(animated)
        print("뷰가 노출될때마다 호출됨.")
    }
//
//    override func didReceiveMemoryWarning() {//앱이 메모리 경고를 받으면 뷰컨트롤러한테 보냄
//
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    
    
    
    @IBAction func recordAutio(_ sender: Any) {
      //  print("record button was pressed")
        recordingLabel.text = "recording in progress"
        stopRecordingButton.isEnabled = true
        recordingButton.isEnabled = false

    
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
       
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    
    }
    
    

    @IBAction func stopRecording1(_ sender: Any) {
        // print("stop recording button was pressed")
        recordingButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "tap to Record"
        
        audioRecorder.stop()//audio stop하고 audiosession을 inactive시켜
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

}

