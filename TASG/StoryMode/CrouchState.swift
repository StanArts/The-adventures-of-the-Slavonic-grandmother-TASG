//
//  CrouchState.swift
//  StoryMode3
//
//  Created by user149141 on 2/2/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit
import GameplayKit

class CrouchState : GKState {
    
    var cNode : CharacterNode?
    
    init(withNode node: CharacterNode) {
        cNode = node
    }
    
    override func didEnter(from previousState: GKState?) {
        cNode?.color = UIColor.blue
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if !(cNode?.down)! {
            self.stateMachine?.enter(NormalState.self)
        }
        
        cNode?.xScale = approach(start: (cNode?.xScale)!, end: (cNode?.facing)!, shift: 0.05)
        cNode?.yScale = approach(start: (cNode?.yScale)!, end: 1.0, shift: 0.05)
    }
    
    func approach (start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat{
        
        if (start < end) {
            return min(start + shift, end);
        } else {
            return max(start - shift, end);
        }
    }
}
