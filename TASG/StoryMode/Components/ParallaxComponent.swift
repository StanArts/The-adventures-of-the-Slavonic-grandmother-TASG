//
//  ParallaxComponent.swift
//  StoryMode3
//
//  Created by user149141 on 2/6/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class ParallaxComponent: GKComponent {
    
    @GKInspectable var layer : Int = 1
    var camera : SKCameraNode?
    var node : SKNode?
    var dX: CGFloat = 1.1
    var dY: CGFloat = 1.2
    var previousPosition: CGPoint?
    
    func prepareWith(camera: SKCameraNode) {
        
        if camera != nil {
            self.camera = camera
            previousPosition = camera.position // ?
        }
        
        if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
            node = nodeComponent.node
        }
        
        switch layer {
        case 1:
            dX = 15
            dY = 5
        case 2:
            dX = 10
            dY = 4
        case 3:
            dX = 5
            dY = 2
        case 4:
            dX = 2
            dY = 1.9
        case 5:
            dX = 1.7
            dY = 1.5
        case 6:
            dX = 1.3
            dY = 1.25
        case 7:
            dX = 1.1
            dY = 1.2
        default:
            print("nod valid layer value")
        }
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        let difX = ((camera?.position.x)! - (previousPosition?.x)!) / dX
        let difY = ((camera?.position.y)! - (previousPosition?.y)!) / dY
        
        node?.position = CGPoint(x: (node?.position.x)! + difX, y: (node?.position.y)! + difY)
        
        previousPosition = camera?.position
    }
    
}
