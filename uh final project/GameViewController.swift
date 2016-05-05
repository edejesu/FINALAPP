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

    

  
    override func viewDidLoad()
    {
        view.backgroundColor = UIColor.blackColor()
        super.viewDidLoad()
        //example square
        let ball = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        ball.backgroundColor = UIColor.grayColor()
        view.addSubview(ball)
        ball.layer.cornerRadius = 10
        ball.clipsToBounds = true
        //example barries
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.redColor()
        view.addSubview(barrier)
        
        //makes ball fall
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [ball])
        animator.addBehavior(gravity)
        //making boundries
        collision = UICollisionBehavior(items: [ball])
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame)) //makes barries stay in place when hit by the block
        collision.translatesReferenceBoundsIntoBoundary = true //stays in frame
        animator.addBehavior(collision)

    }
    @IBAction func Swipped(sender: UISwipeGestureRecognizer)
    {
     print("swipped")
    }
    

}
