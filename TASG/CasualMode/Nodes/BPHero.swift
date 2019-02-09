//
//  BPHero.swift
//  CasualMode2
//
//  Created by Stanimir on 9/16/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import Foundation
import SpriteKit

class BPHero : SKSpriteNode {
    
    var isJumping = false
    var isAttacking = false
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Idle__000"), color: UIColor.clear, size: CGSize(width: 30, height: 42))
        
        zPosition = 1.0
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = defaultObstacleCategory | attackObstacleCategory
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    func run() {
        animateRun()
    }
    
    func slide() {
        animateSlide()
    }
    
    func jump() {
        
        if !isJumping {
         isJumping = true
         animateJump()
            
            let jumpHeight: CGFloat = 90.0
            let jumpTime: TimeInterval = 0.3
            
            let moveUp = SKAction.moveBy(x: 0, y: jumpHeight, duration: jumpTime)
            let moveDown = SKAction.moveBy(x: 0, y: -jumpHeight, duration: jumpTime)
            let moveSequence = SKAction.sequence([moveUp, moveDown])
            
            run(moveSequence, completion: { 
                self.isJumping = false
                self.animateRun()
            })
        }
    }
    
    func attack() {
        isAttacking = true
        animateAttack()
    }
    
    func die() {
        physicsBody?.affectedByGravity = true
        physicsBody?.applyImpulse(CGVector(dx: -10, dy: 50))
        animateDead()
    }
    
    // MARK: Animations
    func animateRun() {
        
        removeAllActions()
        let frames = framesForAnimation(name: "Run")
        let running = SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.03, resize: true, restore: true))
        run(running)
    }
    
    func animateSlide() {
        
        let yAdjustDistance: CGFloat = 14.0
        let adjustDown = SKAction.moveBy(x: 0, y: -yAdjustDistance, duration: 0.0)
        run(adjustDown)
        
        let frames = framesForAnimation(name: "Slide")
        let slide = SKAction.animate(with: frames, timePerFrame: 0.05, resize: true, restore: true)
        run(slide) { //!!! No void in!
            
            let adjustYUP = SKAction.moveBy(x: 0, y: yAdjustDistance, duration: 0.0)
            self.run(adjustYUP)
            self.animateRun()
        } 
        
    }
    
    func animateJump() {
        removeAllActions()
        let frames = framesForAnimation(name: "Jump")
        run(SKAction.animate(with: frames, timePerFrame: 0.05, resize: true, restore: true))
    }
    
    func animateAttack() {
        removeAllActions()
        let frames = framesForAnimation(name: "Attack")
        run(SKAction.animate(with: frames, timePerFrame: 0.05, resize: true, restore: true)) {
            () -> Void in
            self.animateRun()
            self.isAttacking = false
        }
    }
    
    func animateDead() {
        removeAllActions()
        let frames = framesForAnimation(name: "Dead")
        run(SKAction.animate(with: frames, timePerFrame: 0.05, resize: true, restore: false))
        texture = SKTexture(imageNamed: "Dead__009")
    }
    
    
    func framesForAnimation(name: String) -> [SKTexture] {
        
        let atlas = SKTextureAtlas(named: "\(name)@2x")
        var frames = [SKTexture]()
        
        let numberOfImages = atlas.textureNames.count
        for i in 0 ..< numberOfImages {
            let textureName = "\(name)__00\(i)"
            frames.append(atlas.textureNamed(textureName))
        }
        
        return frames
    }
}
