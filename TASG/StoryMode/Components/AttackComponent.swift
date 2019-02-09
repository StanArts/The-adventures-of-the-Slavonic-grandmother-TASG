//
//  AttackComponent.swift
//  StoryMode3
//
//  Created by user149141 on 2/7/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class AttackComponent : GKComponent {
    var cNode : CharacterNode?
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if (cNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? CharacterNode
            }
        }
        
        if cNode?.stateMachine?.currentState is AttackState {
            if cNode?.hitBox != nil {
                if let scene = cNode?.parent as! GameScene? {
                    for enemy in scene.enemies {
                        if (cNode?.hitBox?.intersects((enemy.hurtBox)!))! {
                            if !(cNode?.hitBox?.ignoreList.contains((enemy.hurtBox)!))! {
                                cNode?.hitBox?.ignoreList.append((enemy.hurtBox)!)
                                enemy.hitBy = cNode?.hitBox
                                enemy.hit = true
                            }
                        }
                    }
                }
            }
        }
    }
}
