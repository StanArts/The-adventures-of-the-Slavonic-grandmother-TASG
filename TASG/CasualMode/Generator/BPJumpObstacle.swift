//
//  BPJumpObstacle.swift
//  CasualMode2
//
//  Created by Stanimir on 11/9/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPJumpObstacle: BPObstacle {

    init() {
        super.init(texture: SKTexture(imageNamed: "jumpObstacle"), color: UIColor.clear, size: CGSize(width: 25, height: 40))
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = defaultObstacleCategory
        physicsBody?.density = 99999
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
