//
//  RecordSoundsViewController.swift
//  PitchPerfectSH
//
//  Created by SH MAC on 2017. 1. 10..
//  Copyright © 2017년 udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate, AVAudioPlayerDelegate  {
    
    var audioRecorder: AVAudioRecorder!
    var progressTimer: Timer!
    var audioPlayer: AVAudioPlayer!
    let timePlaySeletor: Selector = #selector(RecordSoundsViewController.updateRecordTime)
    

    

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordTime: UILabel!
    

    override func viewDidLoad() {// 뷰컨트롤러의 뷰가 메모리에 로드된 이후에 호출됨
    super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {//뷰 컨트롤러에 뷰가 뷰 계층에 추가 될 예정임을 알립니다. 뷰가 노출될때마다 호출됨
        
        super.viewWillAppear(animated)
    }
 
//    override func didReceiveMemoryWarning() { AVFoundation 강의(4강)부터는 필요없대
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    
    @IBAction func recordAudio(_ sender: Any) {
        initPlay()
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlaySeletor, userInfo: nil, repeats: true)//0.1초 간격으로 타이머를 생성

    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop() //audio stop하고 audiosession을 inactive시켜
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)//stop recording segue를 부르고 경로(path 를 보내고 기록파일을 여기에 위치하게 한다
        }else{
            print("recording was not successful")
        }
    }
    
    func convertTime(time:TimeInterval) -> String{

        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    func initPlay(){
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath!)
        
        let session = AVAudioSession.sharedInstance()//sharedInstance를 쓰면 모든 기기에서 호환이 된데
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
       
        
        recordTime.text = convertTime(time: 0)

        
    }
    
    func updateRecordTime(){
        recordTime.text = convertTime(time: audioRecorder.currentTime)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
  
}


