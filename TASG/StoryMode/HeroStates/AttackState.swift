//
//  AttackState.swift
//  StoryMode3
//
//  Created by user149141 on 2/7/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class AttackState : GKState {
    var cNode : CharacterNode?
    
    var activeTime = 0.4
    private var lastUpdateTime : TimeInterval = 0
    
    init(with node: CharacterNode) {
        cNode = node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = seconds
        }
        
        if activeTime >= 0 {
            activeTime = activeTime - lastUpdateTime
            
            if (activeTime <= 0.3 && activeTime >= 0.1) {
                if (cNode?.hitBox == nil) {
                    cNode?.createHitBox(size: CGSize(width: 25, height: 30))
                    cNode?.hitBox?.xHit = 2.0 * -(cNode?.facing)!
                    cNode?.hitBox?.hitStun = 30
                }
            } else {
                if (cNode?.hitBox != nil) {
                    cNode?.hitBox?.removeFromParent()
                    cNode?.hitBox = nil
                }
            }
        } else {
            cNode?.attack1 = false
            stateMachine?.enter(NormalState.self)
            activeTime = 0.4
        }
        
        self.lastUpdateTime = seconds
    }
}
