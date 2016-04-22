//
//  2GameViewController.swift
//  uh final project
//
//  Created by edejesu on 4/21/16.
//  Copyright © 2016 edejesu. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion


class _GameViewController: GameViewController
{
    let motionManager: CMMotionManager = CMMotionManager()
    var paddle: SKSpriteNode!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()

    }

    func didMoveToView()
    {
        motionManager.startAccelerometerUpdates()

        // Get node of object to move
        let paddle = childNodeWithName(PaddleCategoryName) as! SKSpriteNode
        
        // Get MotionManager data
        if let data = motionManager.accelerometerData {
            
            // Only get use data if it is "tilt enough"
            if (fabs(data.acceleration.x) > 0.2) {
                
                // Apply force to the moving object
                paddle.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(data.acceleration.x), 0))
                
            }
        }
        
    }
    
}
