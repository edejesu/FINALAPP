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

    
    @IBOutlet weak var brickView: UIView!

  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)


     brickView.backgroundColor = UIColor(patternImage: UIImage(named: "brick")!)
        //example square
        ball = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        ball.backgroundColor = UIColor.grayColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = 10
        ball.clipsToBounds = true
        // ball properities
        addBehaviorsToBricks()


        //makes ball fall
       // animator = UIDynamicAnimator(referenceView: brickView)
       gravity = UIGravityBehavior(items: [ball])
       animator.addBehavior(gravity)
        //making boundries
     //   collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        //makes barries stay in place when hit by the block
        //stays in frame
        movingBricks()
        //behaviors to moving brick
        
        
        
        
        
        
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: ("Swipped:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: ("Swipped:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        self.view!.addGestureRecognizer(leftSwipe)
        self.view!.addGestureRecognizer(rightSwipe)
        //added !
        
        ball.addGestureRecognizer(rightSwipe)
        ball.addGestureRecognizer(leftSwipe)
        ball.userInteractionEnabled = true
        swipe.enabled = true
        
        Swipped(rightSwipe)
        Swipped(leftSwipe)
        
        
        
   
    }
    
    
    
    
    
    
    
    
    func addBehaviorsToBricks()
    {
        let brickBehavior = UIDynamicItemBehavior(items: [brickView])
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
    
    
    
    
    
    
    
    
    
    
    @IBAction func Swipped(sender: UISwipeGestureRecognizer)
    {
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: ("Swipped:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: ("Swipped:"))
        
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
                var ballPosition = CGPointMake(self.ball.frame.origin.x - 100.0, self.ball.frame.origin.y);
                ball.frame = CGRectMake( ballPosition.x , ballPosition.y , self.ball.frame.size.width, self.ball.frame.size.height)
                }
        
        if (sender.direction == .Right)
                {
                    print("Swipe Right")
                    var ballPosition = CGPointMake(self.ball.frame.origin.x + 100.0, self.ball.frame.origin.y);
                                                                            //original was 50.0
                    ball.frame = CGRectMake( ballPosition.x , ballPosition.y , self.ball.frame.size.width, self.ball.frame.size.height)
                    
                    // ORIGINAL: var ballPosition = CGPointMake(self.ball.frame.origin.x + 50.0, self.ball.frame.origin.y);
                    // ORIGINAL First One: var ballPosition = CGPointMake(self.ball.frame.origin.x - 50.0, self.ball.frame.origin.y);
                }
        
     print("swipped")
        
    }
    
  
    
    
    
    
    
    
    
    
    
    
    
    
   func movingBricks()
   {
   // NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, #selector: selector(GameViewController.obstacleMove), userInfo: nil, repeats: true)
    
    collision = UICollisionBehavior(items: [ball, brickView])
    collision.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(collision)
    

  //  collision.addBoundaryWithIdentifier("ball", forPath: UIBezierPath(rect: ball.frame))
    //  collision.addBoundaryWithIdentifier("brickView", forPath: UIBezierPath(rect: brickView.frame))


  

    }
    func obstacleMove(){
        brickView.center = CGPointMake(brickView.center.x, brickView.center.y-1)
        brickView.center = CGPointMake(brickView.center.x, brickView.center.y-1)
        animator.updateItemUsingCurrentState(brickView)
        animator.updateItemUsingCurrentState(ball)
    }
    
    

}
