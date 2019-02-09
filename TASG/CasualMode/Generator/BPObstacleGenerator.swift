//
//  BPObstacleGenerator.swift
//  CasualMode2
//
//  Created by Stanimir on 11/9/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPObstacleGenerator: SKSpriteNode {
    
    let bpSlideObstacleHeight: CGFloat = 50.0
    
    var timer: Timer!
    var obstacles = [BPObstacle]()
    var obstacleTrackers = [BPObstacle]()
    
    init (size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startGeneratingObstaclesWithInterval(interval: TimeInterval) {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(BPObstacleGenerator.generateRandomObstacle), userInfo: nil, repeats: true)
    }
    
    func generateRandomObstacle() {
        let rand = arc4random() % 3
        if rand == 0 {
            generateJumpObstacle()
        } else if rand == 1 {
            generateAttackObstacle()
        } else {
            generateSLideObstacle()
        }

    }
    
    func generateJumpObstacle() {
        let obstacle = BPJumpObstacle()
        obstacle.position = CGPoint(x: frame.size.width/2 + obstacle.frame.size.width/2,
                                    y: -frame.size.height/2 + obstacle.frame.size.height/2)
        handleObstacle(obstacle: obstacle)
    }
    
    func generateAttackObstacle() {
        let obstacle = BPAttackObstacle()
        obstacle.position = CGPoint(x: frame.size.width/2 + obstacle.frame.size.width/2,
                                    y: -frame.size.height/2 + obstacle.frame.size.height/2)
        handleObstacle(obstacle: obstacle)
    }
    
    func generateSLideObstacle() {
        let obstacle = BPSlideObstacle()
        obstacle.position = CGPoint(x: frame.size.width/2 + obstacle.frame.size.width/2,
                                    y: -frame.size.height/2 + obstacle.frame.size.height/2 + bpSlideObstacleHeight)
        handleObstacle(obstacle: obstacle)
    }
    
    func handleObstacle(obstacle: BPObstacle) {
        addChild(obstacle)
        obstacles.append(obstacle)
        obstacleTrackers.append(obstacle)
        obstacle.start()
    }
    
    func stop() {
        if timer != nil {
            timer.invalidate()
        }
        
        for obstacle in obstacles {
            obstacle.stop()
        }
    }
}
