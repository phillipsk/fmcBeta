//
//  Mp3FeedViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/12/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import AVFoundation

class Mp3FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var playButton: UIBarButtonItem!
    
    var images:[UIImageView] = []
    var titles:[String] = []
    var timestamps:[String] = []
    var audioLinks:[String] = []
    var currentPlayIndex:Int!
    var Spacer: [UIView] = []
    
    
    @IBOutlet weak var mp3FeedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, mode: AVAudioSessionModeDefault, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
        
    NotificationCenter.default.addObserver(self, selector: #selector(playRemote(notification:)), name: NSNotification.Name("didClickPlay"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(backRemote(notification:)), name: NSNotification.Name("didClickBack"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(forwardRemote(notification:)), name: NSNotification.Name("didClickForward"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(skipForward(notification:)), name: NSNotification.Name("didClickFastForward"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(skipBackward(notification:)), name: NSNotification.Name("didClickRewind"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateVolume(notification:)), name: NSNotification.Name("sliderMoved"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(seekToPoint(notification:)), name: NSNotification.Name("progressSliderMoved"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(mute(notification:)), name: NSNotification.Name("didClickMute"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(unmute(notification:)), name: NSNotification.Name("didClickUnmute"), object: nil)
    
        
        
        
    mp3FeedTableView.delegate = self
    mp3FeedTableView.dataSource = self
    
    let urlString:String = "http://fellowshipmission.church/mp3/api.php"
    let formattedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url:URL = URL(string: formattedUrl!)!
    let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
    if data != nil {
                
    do {
                    
    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
    print(json)
                    
    guard let jsonResponse = json as? [String: Any] else{
                        
    print("could not convert json into form [String: Any]")
    return
    }
                    
    if let files = jsonResponse["audio_files"] as? [[String: Any]] {
//  print(files)
                        
    for file in files {
    print(file["name"])
    print(file["path"])
    print(file["time_created"])
                            
    self.titles.append(file["name"] as! String)
    self.audioLinks.append(file["path"] as! String)
                            
//    let timestamp = file["time_created"] as! TimeInterval
//    let timeDate:NSDate = NSDate(timeIntervalSince1970: timestamp/1000)
//    let date:Date = timeDate as Date
//
//    self.timestamps.append(date.timeAgoDisplay())
        
                            
    }
    }
        
    } catch {
                    
                    
    }
                
    }
            
    DispatchQueue.main.async {
    self.mp3FeedTableView.reloadData()
    }
            
    print("got here")
            
    if err != nil {
    print(err!)
    }

    }
    task.resume()
        
    
    }
    
    @objc func unmute(notification: NSNotification) {
        if (self.player != nil && self.player.isPlaying) {
            self.player.isMuted = false
        }
    }
    
    @objc func mute(notification: NSNotification) {
        if (self.player != nil && self.player.isPlaying) {
            self.player.isMuted = true
        }
    }
    
    @objc func playRemote(notification: NSNotification) {
    if (self.player != nil) {
    if (self.player!.isPlaying) {
    self.player.pause()
    } else {
    self.player.play()
                
    }
    }
    }
    
    @objc func seekToPoint(notification: NSNotification) {
        
    if let val = notification.userInfo?["value"] as? Int64 {
        let targetTime:CMTime = CMTimeMake(val, 1)
            
    player!.seek(to: targetTime)
    if player!.rate == 0
    {
    player?.play()
    }
    }
        
    }
    
    
    
    @objc func backRemote(notification: NSNotification) {
    if (currentPlayIndex != nil) {
    if (self.player != nil) {
    currentPlayIndex = (currentPlayIndex - 1) % self.audioLinks.count
    if (self.player.isPlaying) {
    self.player.pause()
    let tempButton = UIButton(type: .system)
    tempButton.tag = currentPlayIndex
    self.play(sender: tempButton)
    }
    }
        
    } else {
    currentPlayIndex = 0
    let tempButton = UIButton(type: .system)
    tempButton.tag = currentPlayIndex
    self.play(sender: tempButton)
    }
        
        
    }
    @objc func forwardRemote(notification: NSNotification) {
    if (currentPlayIndex != nil) {
    if (self.player != nil) {
        print("index before: \(currentPlayIndex)")
    currentPlayIndex = (currentPlayIndex + 1) % self.audioLinks.count
        print("index after: \(currentPlayIndex)")
    if (self.player.isPlaying) {
    self.player.pause()
    let tempButton = UIButton(type: .system)
    tempButton.tag = currentPlayIndex
    self.play(sender: tempButton)
    }
    }



    } else {
    currentPlayIndex = 0
    let tempButton = UIButton(type: .system)
    tempButton.tag = currentPlayIndex
    self.play(sender: tempButton)
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell") as! AudioFeedTableViewCell
  //cell.mp3Timestamp.text = timestamps[indexPath.row]
    cell.mp3TitleLabel.text = titles[indexPath.row]
    cell.playButton.tag = indexPath.row
    cell.playButton.addTarget(self, action: #selector(self.play(sender:)), for: .touchUpInside)
    
        
    return cell
    }
    
    var player:AVPlayer!
    
    
    var sliderBoundDict:[String: Float64]!
    var titleDict:[String:String]!
    @objc func play(sender: UIButton) {
    currentPlayIndex = sender.tag
        
    var title = titles[currentPlayIndex]
        
        titleDict = ["value": title]
    NotificationCenter.default.post(name: NSNotification.Name("sendTitleForPlay"), object: nil, userInfo: titleDict)
        
        
    let urlString = audioLinks[sender.tag]
    let formattedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let url = URL(string: formattedString!)
        
    do {
            
    let playerItem = AVPlayerItem(url: url!)

    self.player = try AVPlayer(playerItem:playerItem)
        self.player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                var timeDict:[String:Float64]
                let time:Float64 = CMTimeGetSeconds(self.player!.currentTime())
//                self.playbackSlider!.value = Float ( time );
                timeDict = ["value": time]
                NotificationCenter.default.post(name: NSNotification.Name("updateSliderPosition"), object: nil, userInfo: timeDict)
                
            }
        }
    let duration : CMTime = playerItem.asset.duration
    let seconds : Float64 = CMTimeGetSeconds(duration)
    self.sliderBoundDict = ["value": seconds]
    NotificationCenter.default.post(name: NSNotification.Name("didReadyPlay"), object: nil, userInfo: sliderBoundDict)
            
    player!.volume = 1.0
    player!.play()
            
    } catch let error as NSError {
    self.player = nil
    print(error.localizedDescription)
    } catch {
    print("AVAudioPlayer init failed")
    }
    }
    
    @objc func skipForward(notification: NSNotification) {
        
    if (self.player != nil) {
            
    if (self.player.isPlaying) {
    self.player.pause()
                
    }
            
    guard let duration = self.player.currentItem?.duration else {
    return
    }
    let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
    let newTime = playerCurrentTime + 15.0
            
    if newTime < (CMTimeGetSeconds(duration) - 15.0) {
        let time2: CMTime = CMTimeMake(Int64(newTime * 1000 as Float64), 1000)
    player.seek(to: time2, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    player.play()
    }
            
    }
    }
    
    @objc func updateVolume(notification: NSNotification) {
        
    if let val = notification.userInfo?["value"] as? Float {
            self.player.volume = val
    }
    }
    
    @IBAction func nowPlaying(_ sender: Any) {
        
       
        performSegue(withIdentifier: "Playing", sender: nil)
        
    }
    @objc func skipBackward(notification: NSNotification) {
    if (self.player != nil) {
            
    if (self.player.isPlaying) {
    self.player.pause()
    }
            
    guard let duration = self.player.currentItem?.duration else {
    return
    }
    let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
    var newTime = playerCurrentTime - 15.0
            
    if newTime < 0 {
    newTime = 0
    }
        let time2: CMTime = CMTimeMake(Int64(newTime * 1000 as Float64), 1000)
    player.seek(to: time2, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    player.play()
    }
    }
        
    }
    extension AVPlayer {
    var isPlaying: Bool {
    return rate != 0 && error == nil
    }
    }
