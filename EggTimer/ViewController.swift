//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {
    

    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    
    var totalTime : Int = 0
    var secondsPassed : Int = 0
    var timer = Timer()
    
    @IBOutlet weak var eggLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var hardness : String = "nothing"
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        secondsPassed = 0
        hardness = sender.currentTitle!
        eggLabel.text = hardness
//        print(eggTimes[hardness]!)
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var progressScore : Float = 0


    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        }
        else {
            timer.invalidate()
            eggLabel.text = "Done"
            playSound()
        }
    }

}
