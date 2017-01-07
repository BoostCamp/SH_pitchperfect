//
//  ViewController.swift
//  again
//
//  Created by SH MAC on 2017. 1. 1..
//  Copyright © 2017년 udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {// 뷰컨트롤러의 뷰가 메모리에 로드된 이후에 호출됨
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {//뷰 컨트롤러에 뷰가 뷰 계층에 추가 될 예정임을 알립니다.
        super.viewWillAppear(animated)
        print("이미 나오고 있던데 뭐지")
    }

    override func didReceiveMemoryWarning() {//앱이 메모리 경고를 받으면 뷰컨트롤러한테 보냄
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
       // print("record button was pressed")
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false // record이미지로 된 버튼 비활성화
    }
    @IBAction func stopRecording(_ sender: Any) {
        //print("stop recording button was pressed")
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
    }
}

