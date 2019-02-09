//
//  CharacterNode.swift
//  StoryMode1
//
//  Created by user149141 on 2/2/19.
//  Copyright © 2019 StanArts. All rights reserved.
//

import GameplayKit
import SpriteKit

class CharacterNode: SKSpriteNode {
    
    var left = false
    var right = false
    var down = false
    
    var jump = false
    var landed = false
    var grounded = false
    
    var attack1 = false
    
    var maxJump: CGFloat = 30.0
    
    var airAccel: CGFloat = 0.1
    var airDecel: CGFloat = 0.0
    var groundAccel: CGFloat = 0.2
    var groundDecel: CGFloat = 0.5
    
    var facing: CGFloat = 1.0
    
    var hSpeed: CGFloat = 0.0
    
    var walkSpeed: CGFloat = 5
    
    var hurtBox: HurtBox?
    var hitBox: HitBox?
    
    var hit = false
    var hitStun: CGFloat = 0
    var hitBy: HitBox?
    
    
    var stateMachine: GKStateMachine?
    
    func setHurtBox(size: CGSize) {
        hurtBox = HurtBox(color: .green, size: size)
        hurtBox?.position = CGPoint(x: (hurtBox?.xOffset)!, y: (hurtBox?.yOffset)!)
        hurtBox?.alpha = (hurtBox?.image_alpha)!
        hurtBox?.zPosition = 50
        self.addChild(hurtBox!)
    }
    
    func createHitBox(size: CGSize) {
        hitBox = HitBox(color: .red, size: size)
        hitBox?.position = CGPoint(x: (hitBox?.xOffset)!, y: (hitBox?.yOffset)!)
        hitBox?.alpha = (hitBox?.image_alpha)!
        hitBox?.zPosition = 50
        self.addChild(hitBox!)
    }
        
    func setUpStateMachine() {
        let normalState = NormalState(with: self)
        let crouchState = CrouchState(withNode: self)
        let attackState = AttackState(with: self)
        let damageState = DamageState(with: self)
        stateMachine = GKStateMachine(states: [normalState, crouchState, attackState, damageState])
        stateMachine?.enter(NormalState.self)
    }
    
    func createPhysics() {
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 43), center : CGPoint(x: 0, y: 0))
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GROUND
    }
    
}
