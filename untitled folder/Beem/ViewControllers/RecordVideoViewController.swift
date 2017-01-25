//
//  ViewController.swift
//  Beem
//
//  Created by Abhishek Shukla on 17/01/17.
//  Copyright © 2017 mobulous. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVideoViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var recordButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoProgressBar: UIProgressView!
    @IBOutlet weak var recordVideoButton: UIButton!
    var timer: Timer?
    var cameraManager = CameraManager()
    var videoUrlList:[URL] = []
    
    
    var progressCount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeProgressBar()
        updateRecordButtonUI()
        initializeCameraToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cameraManager.resumeCaptureSession()
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.cameraManager.stopCaptureSession()
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

    extension RecordVideoViewController {
    
    func initializeProgressBar() {
        videoProgressBar.progress = 0.0
    }
    
    func initializeCameraToView() {
        
        let result = self.cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: .videoWithMic)
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
            saveAndShowSession()
        }
    }
    @IBAction func recordButtonTouchUpOutSide(_ sender: Any) {
        print("Button Touch Up OutSide")
        updateRecordButtonUI()
        if timer != nil {
            timer?.invalidate()
        }
        if videoProgressBar.progress > 0 {
            saveAndShowSession()
        }
    }
    @IBAction func recordButtonTouchDown(_ sender: Any) {
        print("Button Touch Down")
        if videoProgressBar.progress > 0.0 {
            let videoTagView = UIView(frame: CGRect(x: progressCount + 50, y: 10, width: 10, height: 6))
            videoTagView.layer.backgroundColor = UIColor.white.cgColor
            videoProgressBar.addSubview(videoTagView)
        }
        initiateTimer()
        recordVideoButton.layer.bounds.size = CGSize(width: 80, height: 80)
        recordVideoButton.layer.cornerRadius = 40
        recordVideoButton.layer.backgroundColor = UIColor.red.cgColor
        self.cameraManager.startRecordingVideo()
    }
    
    func initiateProgressBar() {
        guard videoProgressBar.progress < 1.0 && timer != nil else {
            timer?.invalidate()
            timer = nil
            recordVideoButton.isEnabled = false
            getAllVideoAssets()
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
                self.videoUrlList.append(videoURL! as URL)
            }
        }
    }
    
    func getAllVideoAssets() {
        var videoAssetList:[AVAsset] = []
        for url in self.videoUrlList {
            let videoAsset = AVAsset(url: url)
            videoAssetList.append(videoAsset)
        }
        
     mergeVideoArray(arrayVideos: videoAssetList)
    }
}
// MARK: MERGE VIDEO FILES
    extension RecordVideoViewController {
    
    func mergeVideoArray(arrayVideos: [AVAsset]) {
     
//        let mixComposition = AVMutableComposition()
//        for asset in arrayVideos {
//            let videoTimeRange=CMTimeRangeMake(kCMTimeZero, asset.duration)
//            let videoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
//
//        }
        
    }
}

