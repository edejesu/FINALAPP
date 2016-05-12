//
//  GameViewController.swift
//  uh final project
//
//  Created by edejesu on 4/5/16.
//  Copyright (c) 2016 edejesu. All rights reserved.
//  test

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, UICollisionBehaviorDelegate
{
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var ball = UIView()
    var brick = UIView()
    var brickArray : [UIView] = []
    var timer = NSTimer()
    var counter = 0

    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)

        ball = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        ball.backgroundColor = UIColor.grayColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = 10
        ball.clipsToBounds = true
        // ball properities
      //  addBehaviorsToBricks()
      // gravity = UIGravityBehavior(items: [ball])
    //   animator.addBehavior(gravity)
       
      //  movingBricks()
   
    }
    @IBAction func startButtonTapped(sender: UIButton)
    {
        addBehaviorsToBricks()
        gravity = UIGravityBehavior(items: [ball])
        animator.addBehavior(gravity)
        movingBricks()
        startButton.alpha = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameViewController.timerAction), userInfo: nil, repeats: true)
    }
    func timerAction()
    {
        counter += 1
        timerLabel.text = "\(counter)"
    }
    
    func addBehaviorsToBricks()
    {
        for brick in brickArray
        {
        let brickBehavior = UIDynamicItemBehavior(items: [brick])
        brickBehavior.allowsRotation = false
        brickBehavior.density = 10000
        brickBehavior.resistance = 0.0
        animator.addBehavior(brickBehavior)
        
        let ballBehavior = UIDynamicItemBehavior(items: [ball])
        ballBehavior.resistance = 0.0
        ballBehavior.elasticity = 0.0
        ballBehavior.density = 0.0
        animator.addBehavior(ballBehavior)
        }
    }
    
    // RANDOM LINE BREAKS
    func lineBreaks()
    {
        for bricks in brickArray
        {
            bricks.willRemoveSubview(bricks)
            //make this random
        }
    }
    @IBAction func Swipped(sender: UISwipeGestureRecognizer)
    {
     print("swipped")
        
    }
    
   func movingBricks()
   {
    NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameViewController.makeBricks), userInfo: nil, repeats: true)
    animator.updateItemUsingCurrentState(brick)


    NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: #selector(GameViewController.obstacleMove), userInfo: nil, repeats: true)
    collision = UICollisionBehavior(items: [ball])
    collision.translatesReferenceBoundsIntoBoundary = false
    animator.addBehavior(collision)

    }
    
    
    func makeBricks()
    {
         let brick = UIView(frame: CGRectMake(0, 600, 500, 30))
        brick.backgroundColor = UIColor.redColor()
        //(patternImage: UIImage(named: "brick")!)
        view.addSubview(brick)
        brickArray.append(brick)
    }
    
    func obstacleMove(){
       
        for brick in brickArray
        {
        
        brick.center = CGPointMake(brick.center.x, brick.center.y-1)
        brick.center = CGPointMake(brick.center.x, brick.center.y-1)
        animator.updateItemUsingCurrentState(brick)
        animator.updateItemUsingCurrentState(ball)
        }
    }
    
    //transfer of data?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
       // var highScore =
        var highScoreView = segue.destinationViewController as! HighScoreViewController
    }
    

}
