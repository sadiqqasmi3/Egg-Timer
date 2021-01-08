//
//  ViewController.swift
//  Egg Timer
//
//  Created by sadiq qasmi on 06/01/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audio:AVPlayer!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var soft: UIButton!
    @IBOutlet weak var medium: UIButton!
    @IBOutlet weak var hard: UIButton!
    let hardness = ["Soft Yolk":500,"Medium Yolk":700,"Hard Yolk":1200]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        audio.pause()
    }
    var timer = Timer()
    var selectedHardness:String = ""
    
    var second = 0
    var senderColor = UIColor()
    @IBAction func buttonPressed(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(trackHardness), userInfo: nil, repeats: true)
        
        selectedHardness = sender.currentTitle!
        senderColor = sender.backgroundColor!
        soft.isEnabled = false
        medium.isEnabled = false
        hard.isEnabled = false
        
    }
    @objc func trackHardness() {
        progressBar.setProgress(Float(second)/Float(hardness[selectedHardness]!), animated: true)
            
        if second < hardness[selectedHardness]! {
            Label.text = "Running..."
            second+=1
            senderColor = .link
            
            
        }else{
            timer.invalidate()
            playAlarm()
            Label.text = "Done!"
            senderColor = .clear
            
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        second = 0
        selectedHardness = ""
        Label.text = "Start"
        progressBar.progress = 0
        soft.isEnabled = true
        medium.isEnabled = true
        hard.isEnabled = true
        // To pause or stop audio in swift 5 audio.stop() isn't working
        
        
        
    }
    
    
    func playAlarm() {
        // need to declear local path as url
        let url = Bundle.main.url(forResource: "Alarm", withExtension: "mp3")
        // now use decleared path 'url' to initialize the player
        audio = AVPlayer.init(url: url!)
        // after initialization play audio its just like click on play button
        audio.play()
        
    }
}

