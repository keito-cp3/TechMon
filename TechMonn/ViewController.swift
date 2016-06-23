//
//  ViewController.swift
//  TechMonn
//
//  Created by 松井恵人 on 2016/06/18.
//  Copyright © 2016年 松井恵人. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var levellabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player(name: "勇者", imageName: "yusya.png")
        staminaBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        namelabel.text = player.name
        levellabel.text = "Lv25"
        stamina = 100
        
        util = TechDraUtility()
        
        cureStamina()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        util.playBGM("lobby")
    }
    
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
    }
    
    @IBAction func toBattle() {
        if stamina >= 50 {
            stamina = stamina - 50
            staminaBar.progress = stamina/100
            self.performSegueWithIdentifier("toBattle", sender: nil)
        }else {
            let alert = UIAlertController(title:"バトルには行けません",message: "スタミナを貯めて下さい",preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func cureStamina() {
        staminaTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.updateStaminaValue), userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    func updateStaminaValue() {
        if stamina <= 100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
        }
    }


}

