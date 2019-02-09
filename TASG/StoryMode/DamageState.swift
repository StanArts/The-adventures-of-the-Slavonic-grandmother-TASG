//
//  DamageState.swift
//  StoryMode3
//
//  Created by user149141 on 2/7/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class DamageState: GKState {
    var cNode : CharacterNode?
    var cameraNode: SKCameraNode?
    
    init (with node: CharacterNode) {
        self.cNode = node
    }

    override func didEnter(from previousState: GKState?) {
        if cameraNode == nil {
            if let mainScene = cNode?.parent as? SKScene {
                cameraNode = mainScene.camera
            }
        }
        if cameraNode != nil {
            let shake = SKAction.shake(initialPosition: (cameraNode?.position)!, duration: 0.8, amplitudeX: 16, amplitudeY: 16)
            cameraNode?.run(shake)
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        cNode?.hSpeed = approach(start: (cNode?.hSpeed)!, end: 0, shift: 0.1)
        cNode?.hitStun = (cNode?.hitStun)! - 1
        
        if (cNode?.hitStun)! <= 0 {
            cNode?.hSpeed = 0
            cNode?.physicsBody?.velocity.dx = 0.0
            self.stateMachine?.enter(NormalState.self)
    }
        cNode?.xScale = approach(start: (cNode?.xScale)!, end: (cNode?.facing)!, shift: 0.07)
        cNode?.yScale = approach(start: (cNode?.yScale)!, end: 1, shift: 0.07)
        
        cNode?.position.x = (cNode?.position.x)! - (cNode?.hSpeed)!
        
        cNode?.hurtBox?.position = CGPoint(x: (cNode?.hurtBox?.xOffset)!, y: (cNode?.hurtBox?.yOffset)!)
    }
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat {
        if (start < end) {
            return min(start + shift, end);
        } else {
            return max(start - shift, end);
        }
    }
}
