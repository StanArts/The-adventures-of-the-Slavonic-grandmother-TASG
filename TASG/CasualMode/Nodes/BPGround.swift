//
//  BPGround.swift
//  CasualMode2
//
//  Created by Stanimir on 9/17/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPGround: SKSpriteNode {

    let tileSideLength: CGFloat = 38.0
    var columns: Int!
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width*2, height: size.height))
        
        columns = (Int(size.width / tileSideLength) + 1) * 2
        let rows = Int(size.height / tileSideLength) + 1
        
        for i in 0 ..< rows {
            for j in 0 ..< columns {
                
                var tileType: String!
                if i == 0 {
                    tileType = "ground"
                } else {
                    tileType = "unground"
                }
                
                var tileNumber: Int!
                if j % 2 == 0 {
                    tileNumber = 1
                } else {
                    tileNumber = 2
                }
                
                let tileName = "\(tileType)\(tileNumber)"
                let tile = SKSpriteNode (imageNamed: tileName)
                tile.anchorPoint = CGPoint(x: 0.0, y: 1.0)
                
                let xShift = -self.size.width / 2
                let yShift = self.size.height / 2
                
                tile.position = CGPoint(x: xShift + CGFloat(j) * tileSideLength, y: yShift - CGFloat(i) * tileSideLength)
                addChild(tile)
                
                let texture = SKTexture(imageNamed: "ground1")
                tile.texture = texture
                
                let texture2 = SKTexture(imageNamed: "ground2")
                tile.texture = texture2
                
                let texture3 = SKTexture(imageNamed: "ungound1")
                tile.texture = texture3
                
                let texture4 = SKTexture(imageNamed: "unground2")
                tile.texture = texture4
                 
                //not an optional solution for running multiple textures for the tiles
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start () {
        
        var distanceToMove = CGFloat(columns)/2 * tileSideLength
        if columns % 2 == 0 {
            distanceToMove -= tileSideLength
        }
        
        let moveLeft = SKAction.moveBy(x: -distanceToMove, y: 0.0, duration: TimeInterval(distanceToMove / bpDefaultSpeed))
        let restart = SKAction.moveBy(x: distanceToMove, y: 0.0, duration: 0.0)
        let moveSequence = SKAction.sequence([moveLeft, restart])
        run(SKAction.repeatForever(moveSequence))

    }
    
    func stop() {
        removeAllActions()
    }
}
