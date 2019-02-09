//
//  PlayerTouchControllInput.swift
//  StoryMode1
//
//  Created by Stanimir on 12/26/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import SpriteKit

class PlayerTouchControllInput : SKSpriteNode {
    
    var alphaUnpressed: CGFloat = 0.5
    var alphaPressed: CGFloat = 0.9
    
    var pressedButtons = [SKSpriteNode]()
    
    let buttonDirUp = SKSpriteNode(imageNamed: "button_up")
    let buttonDirLeft = SKSpriteNode(imageNamed: "button_left")
    let buttonDirDown = SKSpriteNode(imageNamed: "button_down")
    let buttonDirRight = SKSpriteNode(imageNamed: "button_right")
    
    let buttonA = SKSpriteNode(imageNamed: "button_A")
    let buttonB = SKSpriteNode(imageNamed: "button_B")
    let buttonX = SKSpriteNode(imageNamed: "button_X")
    let buttonY = SKSpriteNode(imageNamed: "button_Y")
    
    var inputDelegate : ControllInputSourceDelegate?
    
    init(frame: CGRect) {
        
        super.init(texture: nil, color: UIColor.clear, size: frame.size)
        
        setupControls(size: frame.size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControls(size: CGSize) {
        
        addButton(button: buttonDirUp,
                  position: CGPoint(x: -(size.width / 3 ),y: -size.height / 4 + 50),
                  name: "up",
                  scale: 0.40)
        addButton(button: buttonDirLeft,
                  position: CGPoint(x: -(size.width / 3 ) - 50, y: -size.height / 4),
                  name: "left",
                  scale: 0.40)
        addButton(button: buttonDirDown,
                  position: CGPoint(x: -(size.width / 3 ), y: -size.height / 4 - 50),
                  name: "down",
                  scale: 0.40)
        addButton(button: buttonDirRight,
                  position: CGPoint(x: -(size.width / 3 ) + 50, y: -size.height / 4),
                  name: "right",
                  scale: 0.40)
        addButton(button: buttonX,
                  position: CGPoint(x: (size.width / 3 ), y: -size.height / 4 + 50),
                  name: "X",
                  scale: 0.40)
        addButton(button: buttonY,
                  position: CGPoint(x: (size.width / 3 ) - 50, y: -size.height / 4),
                  name: "Y",
                  scale: 0.40)
        addButton(button: buttonB,
                  position: CGPoint(x: (size.width / 3 ), y: -size.height / 4 - 50),
                  name: "B",
                  scale: 0.40)
        addButton(button: buttonA,
                  position: CGPoint(x: (size.width / 3 ) + 50, y: -size.height / 4),
                  name: "A",
                  scale: 0.40)
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String, scale: CGFloat) {
        button.position = position
        button.setScale(scale)
        button.name = name
        button.zPosition = 10
        button.alpha = alphaUnpressed
        self.addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            let location = t.location(in: parent!)
            // for all 4 buttons
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight, buttonA, buttonB, buttonX, buttonY] {
                // I check if they are already registered in the list
                if button.contains(location) && pressedButtons.index(of: button) == nil {
                    pressedButtons.append(button)
                    if ((inputDelegate) != nil){
                        inputDelegate?.follow(command: button.name!)
                    }
                }
                if pressedButtons.index(of: button) == nil {
                    button.alpha = alphaUnpressed
                }
                else {
                    button.alpha = alphaPressed
                }
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            let location = t.location(in: parent!)
            let previousLocation = t.previousLocation(in: parent!)
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight, buttonA, buttonB, buttonX, buttonY] {
                // if I get off the button where my finger was before
                if button.contains(previousLocation)
                    && !button.contains(location) {
                    // I remove it from the list
                    let index = pressedButtons.index(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "cancel \(String(describing: button.name!))")
                        }
                        
                    }
                }
                    // if I get on the button where I wasn't previously
                else if !button.contains(previousLocation)
                    && button.contains(location)
                    && pressedButtons.index(of: button) == nil {
                    // I add it to the list
                    pressedButtons.append(button)
                    if ((inputDelegate) != nil){
                        inputDelegate?.follow(command: button.name!)
                    }
                }
                if pressedButtons.index(of: button) == nil {
                    button.alpha = alphaUnpressed
                }
                else {
                    button.alpha = alphaPressed
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        touchUp(touches: touches, withEvent: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        touchUp(touches: touches, withEvent: event)
        
    }
    
    func touchUp(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        for touch in touches! {
            let location = touch.location(in: parent!)
            let previousLocation = touch.previousLocation(in: parent!)
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight, buttonA, buttonB, buttonX, buttonY] {
                if button.contains(location) {
                    let index = pressedButtons.index(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "stop \(String(describing: button.name!))")
                        }
                    }
                }
                else if (button.contains(previousLocation)) {
                    let index = pressedButtons.index(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        if ((inputDelegate) != nil){
                            inputDelegate?.follow(command: "stop \(String(describing: button.name!))")
                        }
                    }
                }
                if pressedButtons.index(of: button) == nil {
                    button.alpha = alphaUnpressed
                }
                else {
                    button.alpha = alphaPressed
                }
            }
        }
    }
}
