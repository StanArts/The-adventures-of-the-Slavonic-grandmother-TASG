//
//  MenuScene.swift
//  CasualMode2
//
//  Created by Stanimir on 12/15/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class MenuScene: SKScene, GKGameCenterControllerDelegate {
    
    let kButtonColor = UIColor(red: 120.0/255.0, green: 0.0/255.0, blue: 185.0/255.0, alpha: 1.0)
    
    var casualButton: BPButton!
    var storyButton: BPButton!
    var gameCenterButton: BPButton!
    
    override func didMove(to view: SKView) {
        
        loadBackground()
        loadTitle()
        loadButtons()
        loadDummyHero()
    }
    
    func loadBackground() {
        let background = SKSpriteNode(texture: SKTexture(image: UIImage(named: "background")!), color: UIColor.clear, size: CGSize(width: self.frame.size.width, height: self.frame.height))
        background.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
    }

    func loadTitle() {
        let title = SKLabelNode(text: "Baba Stanka")
        title.fontSize = 45.0
        title.position = CGPoint(x: frame.size.width/2 - 12, y: frame.size.height/2)
        addChild(title)
    }
    
    func loadButtons() {
        let separationDistance: CGFloat = 100.0
        
        casualButton = BPButton(text: "Casual Mode", fillColor: kButtonColor)
        casualButton.position = CGPoint(x: frame.size.width/2 - separationDistance, y: frame.size.height/2 - 30)
        addChild(casualButton)
        
        storyButton = BPButton(text: "Story Mode", fillColor: kButtonColor)
        storyButton.position = CGPoint(x: frame.size.width/2 - separationDistance, y: frame.size.height/2 - 30)
        addChild(storyButton)

        
        gameCenterButton = BPButton(text: "Game Center", fillColor: kButtonColor)
        gameCenterButton.position = CGPoint(x: frame.size.width/2 + separationDistance, y: frame.size.height/2 - 30)
        addChild(gameCenterButton)
    }
    
    func loadDummyHero() {
        let hero = BPHero()
        hero.position = CGPoint(x: frame.size.width/2 + 95, y: frame.size.height/2 + 18)
        addChild(hero)
        
        hero.run()
    }
    
    // MARK: Button Actions
    func transitionToGameScene() {
        print("transitionToGameScene")
        let scene = GameScene(size: frame.size)
        view!.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    func transitionToStoryModeScene() {
        print("transitionToStoryModeScene")
        let scene = GameScene2(size: frame.size)
        view!.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    func transitionToGameCenter() {
        print("transitionToGameCenter")
        let vC = self.view?.window?.rootViewController
        let gC = GKGameCenterViewController()
        gC.gameCenterDelegate = self
        vC?.present(gC, animated: true, completion: nil)
    }
    
    // MARK: GKGameCenterControllerDelegate
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            if startButton.frame.contains(location) {
                transitionToGameScene()
            } else if storyButton.frame.contains(location) {
                transitionToStoryModeScene()
            } else if gameCenterButton.frame.contains(location) {
                transitionToGameCenter()
            }
        }
    }
}
