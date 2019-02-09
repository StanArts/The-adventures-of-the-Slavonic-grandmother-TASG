//
//  AnimationComponent.swift
//  StoryMode3
//
//  Created by user149141 on 2/3/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class AnimationComponent : GKComponent {
    
    var cNode : CharacterNode?
    
    @GKInspectable var characterType = 1
    
    var actions = [String : SKAction]()
    var actionNames : [String : String] = ["Idle": "IdleAnim", "Walk" : "WalkAnim", "JumpUp": "JumpAnim", "Apex": "ApexAnim", "JumpDown": "FallAnim", "Crouch": "Crouch", "Attack": "Attack", "Damage": "Damage"]
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var prefix = ""
        
        if (characterType == 2) {
            prefix = "Enemy"
        }
        
        for name in actionNames {
            if name.key == "Idle" || name.key == "Damage" {
                actionNames[name.key] = "\(prefix)\(name.value)"
            }
            
            actions[name.key] = SKAction(named: actionNames[name.key]!)
        }
    }
    
    /*
    var idleAnimation: SKAction?
    var walkAnimation: SKAction?
    var jumpUpAnimation: SKAction?
    var jumpApexAnimation: SKAction?
    var jumpDownAnimation: SKAction?
    var crouchAnimation: SKAction?
 
    
    override init() {
        super.init()
        idleAnimation = SKAction (named: "IdleAnim")
        walkAnimation = SKAction (named: "WalkAnim")
        jumpUpAnimation = SKAction(named: "JumpAnim")
        jumpApexAnimation = SKAction(named: "ApexAnim")
        jumpDownAnimation = SKAction (named: "FallAnim")
        crouchAnimation = SKAction (named: "Crouch")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        idleAnimation = SKAction (named: "IdleAnim")
        walkAnimation = SKAction (named: "WalkAnim")
        jumpUpAnimation = SKAction(named: "JumpAnim")
        jumpApexAnimation = SKAction(named: "ApexAnim")
        jumpDownAnimation = SKAction (named: "FallAnim")
        crouchAnimation = SKAction (named: "Crouch")
    }
     */
    
    override func update(deltaTime seconds: TimeInterval) {
        
        if cNode == nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? CharacterNode
            }
        }
        
        if (cNode?.grounded)! && ((cNode?.physicsBody?.velocity.dy)! < -20.0) {
            cNode?.grounded = false
        }
    
        if cNode?.stateMachine?.currentState is NormalState {
            if (cNode?.grounded)! {
                if (cNode?.left)! || (cNode?.right)! {
                    playAnimation(with: "Walk")
                } else {
                    playAnimation(with: "Idle")
                }
            } else {
                if (cNode?.physicsBody?.velocity.dy)! > 20.0 {
                    playAnimation(with: "JumpUp")
                } else if (cNode?.physicsBody?.velocity.dy)! < 20.0 {
                    playAnimation(with: "JumpDown")
                } else {
                    playAnimation(with: "Apex")
                }
            }
        } else if cNode?.stateMachine?.currentState is CrouchState {
            playAnimation(with: "Crouch")
        } else if cNode?.stateMachine?.currentState is AttackState {
            playAnimation(with: "Attack")
        } else if cNode?.stateMachine?.currentState is DamageState {
            playAnimation(with: "Damage")
        }
    }
    
    func playAnimation (with name: String) {
        if ((cNode?.action(forKey: name)) == nil) {
            cNode?.removeAllActions()
            if (actions[name] != nil) {
                cNode?.run(actions[name]!, withKey: name)
            }
        }
    }
}
        /*
        if cNode == nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? CharacterNode
            }
        }
        
        if (cNode?.grounded)! && ((cNode?.physicsBody?.velocity.dy)! < -20) {
            cNode?.grounded = false
        }
        
        if cNode?.stateMachine?.currentState is NormalState {
            
            if (cNode?.grounded)! {
                if (cNode?.left)! || (cNode?.right)! {
                    if (cNode?.action(forKey: "WalkAnim") == nil) {
                        cNode?.removeAllActions()
                        cNode?.run(walkAnimation!, withKey: "WalkAnim")
                    }
                } else {
                    if (cNode?.action(forKey: "IdleAnim") == nil) {
                    cNode?.removeAllActions()
                    cNode?.run(idleAnimation!, withKey: "IdleAnim")
                    }
                }
                
            } else {
                
                if (cNode?.physicsBody?.velocity.dy)! > 20.0 {
                    if (cNode?.action(forKey: "JumpAnim") == nil) {
                        cNode?.removeAllActions()
                        cNode?.run(jumpUpAnimation!, withKey: "JumpAnim")
                    }
                } else if (cNode?.physicsBody?.velocity.dy)! > 20.0 {
                        if (cNode?.action(forKey: "FallAnim") == nil) {
                            cNode?.removeAllActions()
                            cNode?.run(jumpDownAnimation!, withKey: "FallAnim")
                    }
                } else {
                    if (cNode?.action(forKey: "ApexAnim") == nil) {
                        cNode?.removeAllActions()
                        cNode?.run(jumpApexAnimation!, withKey: "ApexAnim")
                    }
                }
            }
        } else if cNode?.stateMachine?.currentState is CrouchState {
            if (cNode?.action(forKey: "Crouch") == nil) {
                cNode?.removeAllActions()
                cNode?.run(crouchAnimation!, withKey: "Crouch")
            }
        }
    */
