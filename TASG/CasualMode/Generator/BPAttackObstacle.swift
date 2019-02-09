//
//  BPAttackObstacle.swift
//  CasualMode2
//
//  Created by Stanimir on 11/9/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPAttackObstacle: BPObstacle {

    init() {
        super.init(texture: SKTexture(imageNamed: "attackObstacle"), color: UIColor.clear, size: CGSize(width: 30, height: 200))
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = attackObstacleCategory
        physicsBody?.density = 99999
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func explode() {
        texture = nil
        physicsBody = nil
    }
}
