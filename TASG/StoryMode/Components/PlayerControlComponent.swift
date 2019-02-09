//
//  PlayerControlComponent.swift
//  StoryMode1
//
//  Created by Stanimir on 12/26/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import GameplayKit
import SpriteKit

class PlayerControlComponent: GKComponent,  ControllInputSourceDelegate{
    
    
    var touchControlNode : PlayerTouchControllInput?
    var cNode: CharacterNode?
    
    func setupControls(camera : SKCameraNode, scene: SKScene) {
        
        touchControlNode = PlayerTouchControllInput(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = CGPoint.zero
        
        camera.addChild(touchControlNode!)
        
        if (cNode == nil) {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
            cNode = nodeComponent.node as? CharacterNode
            }
        }
    }
    
    func follow(command: String?) {

        if (cNode != nil) {
            switch(command!){
            case ("left"):
                cNode?.left = true
            case "cancel left", "stop left":
                cNode?.left = false
            case "right":
                cNode?.right = true
            case "cancel right", "stop right":
                cNode?.right = false
            case "down":
                cNode?.down = true
            case "cancel down", "stop down":
                cNode?.down = false
            case "A":
                cNode?.jump = true
            case "cancel A", "stop A":
                cNode?.jump = false
            case "B":
                cNode?.attack1 = true
            case "cancel B", "stop B":
                cNode?.attack1 = false
            default: ("command: \(String(describing: command))")
            }
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        cNode?.stateMachine?.update(deltaTime: seconds)
    }
}
