//
//  EnemyControlComponent.swift
//  StoryMode3
//
//  Created by user149141 on 2/7/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class EnemyControlComponent : GKComponent {
    var cNode : CharacterNode?
    
    override func update(deltaTime seconds: TimeInterval) {
        if (cNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? CharacterNode
                cNode?.setUpStateMachine()
                cNode?.setHurtBox(size: CGSize(width: 40, height: 55))
                if let parentScene = cNode?.parent as? GameScene {
                    parentScene.enemies.append(cNode!)
                }
            }
        } else {
            cNode?.stateMachine?.update(deltaTime: seconds)
        }
    }
}
