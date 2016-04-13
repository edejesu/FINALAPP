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

class GameViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var ball = UIView()
    var ballbehavior = UIDynamicItemBehavior()
    var myDynamicAnimator = UIDynamicAnimator()
    var allObjects : [UIView] = []
    var animator : UIDynamicAnimator? = nil
    var gravity = UIGravityBehavior()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ball = UIView(frame: CGRectMake(5, 15, 20, 20))
        ball.layer.cornerRadius = 10
        ball.backgroundColor = UIColor.whiteColor() //for right now keep it white, later change to picture(pizza)
        ball.clipsToBounds = true
        view.addSubview(ball)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [ball])
        animator!.addBehavior(gravity)

        

}
}
