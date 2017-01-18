//
//  ViewController.swift
//  Beem
//
//  Created by Abhishek Shukla on 17/01/17.
//  Copyright © 2017 mobulous. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoProgressBar: UIProgressView!
    @IBOutlet weak var recordVideoButton: UIButton!
    var timer: Timer?
    var cameraManager = CameraManager.sharedInstance
    
    var progressCount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeProgressBar()
        updateRecordButtonUI()
        initializeCameraToView()
    }
    
    func initializeProgressBar() {
        videoProgressBar.progress = 0.0
    }
    
    func initializeCameraToView() {
        
        let result = self.cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: .videoOnly)
        switch result {
        case .accessDenied:
            print("Camera Access Denied")
            break
        case .noDeviceFound:
            print("No Camera Found")
            break
        case .notDetermined:
            print("Camera Not Determind")
            break
        case .ready:
            break
        }
    }
    
    func updateRecordButtonUI() {
        recordVideoButton.layer.bounds.size = CGSize(width: 100, height: 100)
        recordVideoButton.layer.cornerRadius = 50
        recordVideoButton.layer.backgroundColor = UIColor.gray.cgColor
        recordVideoButton.layer.borderWidth = 2.0
        recordVideoButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    func initiateTimer() {
        let timerSelector = #selector(initiateProgressBar)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: timerSelector, userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func recordVideoButtonClicked(_ sender: Any) {
        print("Button Touch Up Inside")
        updateRecordButtonUI()
        if timer != nil {
            timer?.invalidate()
        }
        if videoProgressBar.progress > 0 {
            self.cameraManager.stopCaptureSession()
        }
    }
    @IBAction func recordButtonTouchUpOutSide(_ sender: Any) {
        print("Button Touch Up OutSide")
        updateRecordButtonUI()
        if timer != nil {
            timer?.invalidate()
        }
        if videoProgressBar.progress > 0 {
            self.cameraManager.stopCaptureSession()
        }
    }
    @IBAction func recordButtonTouchDown(_ sender: Any) {
        print("Button Touch Down")
        initiateTimer()
        recordVideoButton.layer.bounds.size = CGSize(width: 80, height: 80)
        recordVideoButton.layer.cornerRadius = 40
        recordVideoButton.layer.backgroundColor = UIColor.red.cgColor
        if videoProgressBar.progress == 0 {
            self.cameraManager.startRecordingVideo()
        }
        else if videoProgressBar.progress > 0 && videoProgressBar.progress < 1 {
            self.cameraManager.resumeCaptureSession()
        }
        
    }
    
    func initiateProgressBar() {
        guard videoProgressBar.progress < 1.0, timer != nil else {
            timer?.invalidate()
            timer = nil
            recordVideoButton.isEnabled = false
            saveAndShowSession()
            return
        }
        self.videoProgressBar.setProgress(Float(progressCount), animated: true)
        progressCount += 0.001
    }
    func saveAndShowSession(){
        
        self.cameraManager.stopVideoRecording { (videoURL, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print(videoURL?.path ?? "No Url Found")
            }
        }
    }
}

