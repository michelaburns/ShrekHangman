//
//  StartingScreenViewController.swift
//  Hangman
//
//  Created by Owner on 2/19/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit
import AVFoundation

class StartingScreenViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer() //for the Background Music
    
    
    var url = NSURL(fileURLWithPath: Bundle.main.path(forResource: "shrekScream", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    
    @IBAction func startButton(_ sender: Any) {
        //Make the screaming sound when the start button is pressed
        audioPlayer.play()
    }
    
    @IBOutlet weak var clickPlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickPlayButton.layer.borderColor = UIColor.white.cgColor
        clickPlayButton.layer.borderWidth = 1.5
        
        // Do any additional setup after loading the view.
        
        //Makes sure Shrek is the name of the shrek font
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        
        //for the Background Music
        do
        {
            let audioPath = Bundle.main.path(forResource: "shrekSong", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL (fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            //Process Error
        }
        player.play()
        
        
        //for the start button
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: url as URL,fileTypeHint: nil)
        }
        catch{
            //handle the error
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
