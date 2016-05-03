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

}
