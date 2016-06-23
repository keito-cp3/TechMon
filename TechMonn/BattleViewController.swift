//
//  BattleViewController.swift
//  TechMonn
//
//  Created by 松井恵人 on 2016/06/18.
//  Copyright © 2016年 松井恵人. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    var moveValueUpTimer: NSTimer!
    var enemy: Enemy = Enemy(name: "ドラゴン", imageName: "monster.png")
    var player: Player = Player(name: "勇者", imageName: "yusya.png")
    let util: TechDraUtility = TechDraUtility()
    
    var isPlayerMoveValueMax: Bool! = true
    
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var enemyMoveBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    @IBOutlet var playerMoveBar: UIProgressView!
    @IBOutlet var playerTPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var attackButton: UIButton!
    @IBOutlet var fireButton: UIButton!
    @IBOutlet var tameruButton: UIButton!
    
    @IBOutlet var backgroundImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initStatus()
        
        moveValueUpTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(BattleViewController.moveValueUp), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initStatus() {
        enemyNameLabel.text = enemy.name
        playerNameLabel.text = player.name
        
        enemyImageView.image = enemy.image
        playerImageView.image = player.image
        
        enemyHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerTPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        playerHPBar.progress = player.currentHP / player.maxHP
        playerTPBar.progress = player.currentTP / player.maxTP
    }
    
    func moveValueUp() {
        
        player.currentMovePoint = player.currentMovePoint + 1
        playerMoveBar.progress = player.currentMovePoint / player.maxMovePoint
        
        if player.currentMovePoint >= player.maxMovePoint {
            isPlayerMoveValueMax = true
            player.currentMovePoint = player.maxMovePoint
        }else {
            isPlayerMoveValueMax = false
        }
        enemy.currentMovePoint = enemy.currentMovePoint + 1
        enemyMoveBar.progress = enemy.currentMovePoint / enemy.maxMovePoint
        
        if enemy.currentMovePoint >= enemy.maxMovePoint {
            self.enemyAttack()
            enemy.currentMovePoint = 0
        }
    }
    
    func enemyAttack() {
        TechDraUtility.damageAnimation(playerImageView)
        util.playSE("SE_attack")
        
        player.currentHP = player.currentHP - enemy.attackPoint
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        util.playBGM("BGM_battle001")
    }
    
    
    @IBAction func attackAction() {
        if isPlayerMoveValueMax == true {
            TechDraUtility.damageAnimation(enemyImageView)
            util.playSE("SE_attack")
            
            enemy.currentHP = enemy.currentHP - player.attackPoint
            enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
            
            
            
            player.currentMovePoint = 0
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
