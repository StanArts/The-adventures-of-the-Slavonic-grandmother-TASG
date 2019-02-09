//
//  HitBox.swift
//  StoryMode3
//
//  Created by user149141 on 2/7/19.
//  Copyright © 2019 user149141. All rights reserved.
//

import SpriteKit

class HitBox : SKSpriteNode {
    var image_alpha: CGFloat = 0.5
    var xOffset: CGFloat = 20.0
    var yOffset: CGFloat = -10.0
    var xHit: CGFloat = 0.0
    var yHit: CGFloat = 0.0
    var life: CGFloat = 0.0
    var hitStun: CGFloat = 60
    var ignore = false
    var ignoreList = [HurtBox]()
    
    
}
