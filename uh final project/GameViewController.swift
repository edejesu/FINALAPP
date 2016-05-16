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
    var swipe = UISwipeGestureRecognizer()
    var brickArray : [UIView] = []
    var brickView = UIView()
    var counter = 0
    var timer = NSTimer()
    var randomIndex = 0
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "pinkPizza")!)
        ball = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        ball.backgroundColor = UIColor.grayColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = 10
        ball.clipsToBounds = true
        addBehaviorsToBricks()
        
    }
    func makeBricks()
    {
        let brick = UIView(frame: CGRectMake(0, 650, 100, 30))
        brick.backgroundColor = UIColor.redColor()
        addBehaviorsToBricks()
        view.addSubview(brick)
        brickArray.append(brick)
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
        ballBehavior.elasticity = 0.2
        ballBehavior.density = 0.0
        ballBehavior.allowsRotation = true
        animator.addBehavior(ballBehavior)
            
       }
    }
    func makeBricks2()
    {
        let brick2 = UIView(frame: CGRectMake(100, 650, 100, 30))
        brick2.backgroundColor = UIColor.redColor()
        addBehaviorsToBricks()
        view.addSubview(brick2)
        brickArray.append(brick2)
    }
    func makeBricks3()
    {
        let brick3 = UIView(frame: CGRectMake(200, 650, 100, 30))
        brick3.backgroundColor = UIColor.redColor()
        addBehaviorsToBricks()
        view.addSubview(brick3)
        brickArray.append(brick3)
    }
    func makeBricks4()
    {
        let brick4 = UIView(frame: CGRectMake(300, 650, 100, 30))
        brick4.backgroundColor = UIColor.redColor()
        addBehaviorsToBricks()
        view.addSubview(brick4)
        brickArray.append(brick4)
    }

    func removeBricks()
    {
         brickArray[randomIndex].alpha = 0.0
            randomIndex += Int(arc4random_uniform(5))

    }
    func obstacleMove()
    {
        for brick in brickArray
        {
            brick.center = CGPointMake(brick.center.x, brick.center.y-1)
            brick.center = CGPointMake(brick.center.x, brick.center.y-1)
            animator.updateItemUsingCurrentState(brick)
            animator.updateItemUsingCurrentState(ball)
        }
    }

    func movingBricks()
    {
        //makes different bricks every 2 seconds
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameViewController.makeBricks), userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameViewController.makeBricks2), userInfo: nil, repeats: true)
         NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameViewController.makeBricks3), userInfo: nil, repeats: true)
         NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameViewController.makeBricks4), userInfo: nil, repeats: true)
        
        //removes one brick from brick array every 2 seconds
         NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(GameViewController.removeBricks), userInfo: nil, repeats: true)
        
        // moves bricks ever .04 seconds
        NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: #selector(GameViewController.obstacleMove), userInfo: nil, repeats: true)
        collision = UICollisionBehavior(items: [ball])
        collision.translatesReferenceBoundsIntoBoundary = false
        animator.addBehavior(collision)
    }
    //puts gravity on ball once time hit 4 seconds
    func checkGravity()
    {
        if timerLabel.text! == "4"
        {
            gravity = UIGravityBehavior(items: [ball])
            animator.addBehavior(gravity)
           // animator.updateItemUsingCurrentState(ball)
        }
    }
    
    
    @IBAction func startButtonTapped(sender: UIButton)
    {
        addBehaviorsToBricks()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameViewController.checkGravity), userInfo: nil, repeats: true)
        movingBricks()
        startButton.alpha = 0.0
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameViewController.timerAction), userInfo: nil, repeats: true)
    }
    //adds time to timer
    func timerAction()
    {
        counter += 1
        timerLabel.text = "\(counter)"
    }
    //moves ball when you swipe right
    func movesRight()
    {
        let ballPosition = CGPointMake(self.ball.frame.origin.x + 2.0, self.ball.frame.origin.y);
        
        ball.frame = CGRectMake(ballPosition.x , ballPosition.y , self.ball.frame.size.width, self.ball.frame.size.height)
    }
    // moves ball when you swipe left
    //figure out a way to make it stop once it hits edge of view
    func movesLeft()
    {
        let ballPosition = CGPointMake(self.ball.frame.origin.x - 2.0, self.ball.frame.origin.y);
        ball.frame = CGRectMake( ballPosition.x , ballPosition.y , self.ball.frame.size.width, self.ball.frame.size.height)
    }
    //
    @IBAction func Swipped(sender: UISwipeGestureRecognizer)
    {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: (#selector(GameViewController.Swipped(_:))))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: (#selector(GameViewController.Swipped(_:))))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        ball.addGestureRecognizer(rightSwipe)
        ball.addGestureRecognizer(leftSwipe)
        ball.userInteractionEnabled = true
        swipe.enabled = true
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
        if (sender.direction == .Left)
            {
                print("did swipe left")
                //moves left function goes below
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(GameViewController.movesLeft), userInfo: nil, repeats: true)

                }
        
        if (sender.direction == .Right)
        {
            print("Swipe Right")
            //moves left function goes below
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(GameViewController.movesRight), userInfo: nil, repeats: true)

                }
          }
    }

    //transfer of data?
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
       // var highScore =
        var highScoreView = segue.destinationViewController as! HighScoreViewController
    }
    


