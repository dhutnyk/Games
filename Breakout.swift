//
//  Breakout.swift
//  Games
//
//  Created by period4 on 4/27/21.
//  Copyright © 2021 period4. All rights reserved.

import UIKit
import AVFoundation

class Breakout: UIViewController, UICollisionBehaviorDelegate{
 
    
    @IBOutlet weak var ball: UIView!
    @IBOutlet weak var paddle: UIView!
   
    @IBOutlet weak var brickOne: UIView!
    @IBOutlet weak var brickTwo: UIView!
    @IBOutlet weak var brickThree: UIView!
    @IBOutlet weak var brickFour: UIView!
    @IBOutlet weak var brickFive: UIView!
    @IBOutlet weak var brickSix: UIView!
    @IBOutlet weak var brickSeven: UIView!
    @IBOutlet weak var brickEight: UIView!
    @IBOutlet weak var brickNine: UIView!
    @IBOutlet weak var brickTen: UIView!
    @IBOutlet weak var brickEleven: UIView!
   
    @IBOutlet weak var startButtonOutlet: UIButton!
    
    var dynamicAnimator: UIDynamicAnimator!
    
    var pushBehavior: UIPushBehavior!
    var collisionBehavior: UICollisionBehavior!
    var ballDynamicBehavior: UIDynamicItemBehavior!
    var paddleDynamicBehavior: UIDynamicItemBehavior!
    var bricksDynamicBehavior: UIDynamicItemBehavior!
    
    @IBAction func startButton(_ sender: UIButton) {
        sender.isHidden = true
        ball.isHidden = false
        paddle.isHidden = false
        print("test")
        let sound = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "Good Luck")
        sound.speak(utterance)
        dynamicBehaviors()
    }
    
  
        var allBricks = [UIView]()
    
        var brickCount = 11
    
        override func viewDidLoad() {
            super.viewDidLoad()
            ball.layer.cornerRadius = 15
        allBricks = [brickOne, brickTwo, brickThree, brickFour, brickFive, brickSix, brickSeven, brickEight, brickNine, brickTen, brickEleven]
        ball.isHidden = true
        paddle.isHidden = true
   
    }
  
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer){
        paddle.center = CGPoint(x: sender.location(in: view).x, y: paddle.center.y)
        dynamicAnimator.updateItem(usingCurrentState: paddle)
    }
  
    
    func dynamicBehaviors() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        pushBehavior = UIPushBehavior(items: [ball], mode: .instantaneous)
        pushBehavior.pushDirection = CGVector(dx: 0.4, dy: 0.7)
        pushBehavior.active = true
        pushBehavior.magnitude = 0.3
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [ball, paddle] + allBricks)
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        
        ballDynamicBehavior = UIDynamicItemBehavior(items: [ball])
        ballDynamicBehavior.allowsRotation = false
        ballDynamicBehavior.elasticity = 1
        ballDynamicBehavior.friction = 0
        ballDynamicBehavior.resistance = 0
        dynamicAnimator.addBehavior(ballDynamicBehavior)
        
        paddleDynamicBehavior = UIDynamicItemBehavior(items: [paddle])
        paddleDynamicBehavior.density = 1000000
        paddleDynamicBehavior.allowsRotation = false
        paddleDynamicBehavior.elasticity = 0.01
        dynamicAnimator.addBehavior(paddleDynamicBehavior)
        
        bricksDynamicBehavior = UIDynamicItemBehavior(items: allBricks)
        bricksDynamicBehavior.density = 1000000
        bricksDynamicBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(bricksDynamicBehavior)
        collisionBehavior.collisionDelegate = self
    }
   
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        for brick in allBricks{
            if item1.isEqual(ball) && item2.isEqual(brick){
                brick.isHidden = true
                collisionBehavior.removeItem(brick)
                brickCount = brickCount - 1
                print(brickCount)
                if brickCount == 0 {
                    winningAlert()
                    //ball.isHidden = true
                    //collisionBehavior.removeItem(ball)
                    ballDynamicBehavior.resistance = 1000
                    startButtonOutlet.isHidden = false
                    brickCount = 11
                    for bricks in allBricks{
                        bricks.isHidden = false
                    }
                }
            }
        }
         
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
            if p.y > paddle.center.y + 20 {
            alert()
            ball.isHidden = true
            collisionBehavior.removeItem(ball)
            }
    }
    func reset() {
        //resets bricks
    }
    func alert()
    {
        let losingAlert = UIAlertController(title: "You Lost!", message: "", preferredStyle: .alert)
        let newGameButton = UIAlertAction(title: "New Game?", style: .default) { (action)
            in self.reset()
        }
        losingAlert.addAction(newGameButton)
        present(losingAlert, animated: true, completion: nil)
    }
    
    
    func winningAlert(){
        let winningAlert = UIAlertController(title: "You Won!", message: "", preferredStyle: .alert)
        
        let newGameButton = UIAlertAction(title: "New Game?", style: .default) { (action)
                   in self.reset()
        }
               winningAlert.addAction(newGameButton)
        present(winningAlert, animated: true, completion: nil)
    }
}

