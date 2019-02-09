//
//  BPButton.swift
//  CasualMode2
//
//  Created by Stanimir on 12/15/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPButton: SKSpriteNode {

    init(text: String, fillColor: UIColor) {
        
        let labelNode = SKLabelNode(text: text)
        labelNode.fontSize = 17.0
        labelNode.fontName = "AmericanTypewriter-Bold"
        labelNode.fontColor = UIColor.white
        labelNode.position.y -= labelNode.frame.size.height/2
        
        let labelPadding: CGFloat = 10.0
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: labelNode.frame.size.width + labelPadding, height: labelNode.frame.size.height + labelPadding))
        
        let fillNode = SKShapeNode(rect: self.frame, cornerRadius: 5.0)
        fillNode.fillColor = fillColor
        addChild(fillNode)
        
        addChild(labelNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
