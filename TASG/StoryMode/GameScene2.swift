//
//  GameScene.swift
//  StoryMode3
//
//  Created by user149141 on 2/2/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene2: SKScene {
    
    var entities = [GKEntity]()
    var enemies = [CharacterNode]()
    var graphs = [String : GKGraph]()
    var physicsDelegate = PhysicsDetection()
    var player: CharacterNode?
    
    private var lastUpdateTime : TimeInterval = 0
    
    var parallaxComponentSystem : GKComponentSystem <ParallaxComponent>?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        
    }
    
    override func didMove(to view: SKView) {
        
        parallaxComponentSystem = GKComponentSystem.init(componentClass: ParallaxComponent.self)
        
        for enitity in self.entities {
            parallaxComponentSystem?.addComponent(foundIn: enitity)
        }
        
        for component in (parallaxComponentSystem?.components)! {
            component.prepareWith(camera: camera!)
        }
        
        if let thePlayer = childNode(withName: "Player") {
            player = thePlayer as! CharacterNode
            if (player != nil) {
                player?.setUpStateMachine()
                player?.createPhysics()
                player?.setHurtBox(size: CGSize(width: 15, height: 35))
                
            }
            if let pcComponent = thePlayer.entity?.component(ofType: PlayerControlComponent.self) {
                pcComponent.setupControls(camera: camera!, scene: self)
            }
        }
        
        if let tilemap = childNode(withName: "ForegroundMap") as? SKTileMapNode {
            giveTileMapPhysicsBody(map: tilemap)
        }
        
        self .physicsWorld.contactDelegate = physicsDelegate
    }
    
    func giveTileMapPhysicsBody(map: SKTileMapNode) {
       
        let tileMap = map
        
        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            
            for row in 0..<tileMap.numberOfRows {
                
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                {
                    let isEdgeTile = tileDefinition.userData?["AddBody"] as? Int
                    if (isEdgeTile != 0) {
                        let tileArray = tileDefinition.textures
                        let tileTexture = tileArray[0]
                        let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                        let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                        _ = CGRect(x: 0, y: 0, width: tileSize.width, height: tileSize.height)
                        let tileNode = SKNode()
                        
                        tileNode.position = CGPoint(x: x, y: y)
                        
                        tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width/2.5), height: (tileTexture.size().height)/4))
                        tileNode.physicsBody?.linearDamping = 0
                        tileNode.physicsBody?.affectedByGravity = false
                        tileNode.physicsBody?.allowsRotation = false
                        tileNode.physicsBody?.restitution = 0
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.physicsBody?.friction = 20.0
                        tileNode.physicsBody?.mass = 30.0
                        tileNode.physicsBody?.contactTestBitMask = 0
                        tileNode.physicsBody?.fieldBitMask = 0
                        tileNode.physicsBody?.collisionBitMask = 0
                        
                        if (isEdgeTile == 1) {
                            tileNode.physicsBody?.restitution = 0.0
                            tileNode.physicsBody?.contactTestBitMask = ColliderType.PLAYER
                        }
                        
                        tileNode.physicsBody?.categoryBitMask = ColliderType.GROUND
                        
                        tileMap.addChild(tileNode)
                    }
                }
            }
        }
    }
    
    func centerOnNode(node: SKNode) {
        self.camera!.run(SKAction.move(to: CGPoint(x: node.position.x, y: node.position.y), duration: 0.5))
    }
    
    override func didFinishUpdate() {
        centerOnNode(node: player!)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        parallaxComponentSystem?.update(deltaTime: currentTime)
        
        self.lastUpdateTime = currentTime
    }
}
