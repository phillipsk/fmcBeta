//
//  AudioMgmtViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/12/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import AVFoundation

class AudioMgmtViewController: UIViewController {

    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fastforwardButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var playImage: UIImageView!
    var progressSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playImage.layer.cornerRadius = 0
        self.playImage.layer.borderWidth = 2
        volumeSlider.isContinuous = false
       // self.playImage.layer.borderColor = UIColor(hue: 24, saturation: 155, brightness: 76, alpha: 2).cgColor
        // Do any additional setup after loading the view.
        progressSlider = UISlider(frame: CGRect(x: 0, y: 0, width: self.playImage.frame.width, height: 20))
        progressSlider.center.x = self.view.center.x
        progressSlider.center.y = self.playImage.frame.origin.y + self.playImage.frame.height + 80
        self.view.addSubview(progressSlider)
        progressSlider.isContinuous = false
        
        //To change the circle on the progress slider use progressSlider.thumbImage()
        //self.progressSlider.setThumbImage(UIImage(named: "")!, for: .normal)
        
        progressSlider.minimumValue = 0
        progressSlider.addTarget(self, action: #selector(progressSliderValueChanged(_:)), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(setSliderUpperBound(notification:)), name: NSNotification.Name("didReadyPlay"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTitle(notification:)), name: NSNotification.Name("sendTitleForPlay"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSlider(notification:)), name: NSNotification.Name("updateSliderPosition"), object: nil)
        
     
    }
    
    @objc func setSliderUpperBound(notification: NSNotification) {
        
        if let val = notification.userInfo?["value"] as? Float64 {
        self.progressSlider.maximumValue = Float(val)
        self.progressSlider.setValue(0.0, animated: true)
        }
        
        
    }
    
    @objc func setTitle(notification: NSNotification) {
        if let val = notification.userInfo?["value"] as? String {
            self.nowPlayingTitle.text = val
        }
    }

    @IBAction func Mp3BackButon(_ sender: Any) {
     self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func play_pauseButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didClickPlay"), object: nil, userInfo: nil)
    
        
        if playButton.isSelected == true {
        playButton.isSelected = false
        playButton.setImage(UIImage(named : "play"), for: UIControlState.normal)
        }else {
        playButton.isSelected = true
        playButton.setImage(UIImage(named : "pause"), for: UIControlState.selected)
    }
        

        
    }
    @objc func updateSlider(notification: NSNotification) {
        if let val = notification.userInfo?["value"] as? Float64 {
            self.progressSlider.setValue(Float(val), animated: true)
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name("didClickBack"), object: nil, userInfo: nil)
    }
    @IBAction func fowardButton(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name("didClickForward"), object: nil, userInfo: nil)
    }
    var isMuted:Bool = false
    @IBAction func muteButton(_ sender: Any) {
        
        if (isMuted) {
            NotificationCenter.default.post(name: NSNotification.Name("didClickUnmute"), object: nil, userInfo: nil)
            
            isMuted = false
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("didClickMute"), object: nil, userInfo: nil)
            isMuted = true
        }
        
        
    }
    @IBAction func rewindButton(_ sender: Any) {
    
    NotificationCenter.default.post(name: NSNotification.Name("didClickRewind"), object: nil, userInfo: nil)
    }
    @IBAction func fastForwardButton(_ sender: Any) {
    
    NotificationCenter.default.post(name: NSNotification.Name("didClickFastForward"), object: nil, userInfo: nil)
        
    }
    var sliderDict:[String: Float]!
    @IBAction func sliderMoved(_ sender: Any) {
    sliderDict = ["value": volumeSlider.value]
        
    NotificationCenter.default.post(name: NSNotification.Name("sliderMoved"), object: nil, userInfo: sliderDict)
    }
    var timeDict:[String: Int64]!
    @objc func progressSliderValueChanged(_ playbackSlider:UISlider)
    {
        
    let seconds : Int64 = Int64(playbackSlider.value)
//  let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
    timeDict = ["value": seconds]
    NotificationCenter.default.post(name: NSNotification.Name("progressSliderMoved"), object: nil, userInfo: timeDict)
        
//        player!.seek(to: targetTime)
//
//        if player!.rate == 0
//        {
//            player?.play()
//        }
    }
    }
