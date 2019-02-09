//
//  BPObstacle.swift
//  CasualMode2
//
//  Created by Stanimir on 11/9/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPObstacle: SKSpriteNode {

    func start() {
        let moveLeft = SKAction.moveBy(x: -bpDefaultSpeed, y: 0.0, duration: 1.0)
        run(SKAction.repeatForever(moveLeft))
    }
    
    func stop() {
        removeAllActions()
    }
}
