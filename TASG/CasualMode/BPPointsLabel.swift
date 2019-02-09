//
//  BPPointsLabel.swift
//  CasualMode2
//
//  Created by Stanimir on 12/6/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit

class BPPointsLabel: SKLabelNode {

    var number: Int = 0
    
    init(number: Int) {
        super.init()
        self.number = number
        text = "\(number)"
        fontSize = 20.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        number += 1
        text = "\(number)"
    }
   
    func setTo(num: Int) {
        number = num
        text = "\(number)"
    }
    
}
