//
//  GameScene.swift
//  CasualMode2
//
//  Created by Stanimir on 9/16/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ground: BPGround!
    var hero: BPHero!
    var generator: BPObstacleGenerator!
    
    var isStarted = false
    var isGameOver  = false
    
    let kButtonColor = UIColor(red: 120.0/255.0, green: 0.0/255.0, blue: 185.0/255.0, alpha: 1.0)
    var backButton: BPButton!
    
    var backgroundMusic: SKAudioNode!
    
    override func didMove(to view: SKView) {
        
        loadBackground()
        loadGround()
        loadHero()
        loadGestureRecognizers()
        loadObstacleGenerator()
        loadPhysicsWorld()
        loadStartLabel()
        loadPointsLabel()
        loadBackButton()
        //loadBackgroundMusic()
    }
    
    // MARK: Loading
    func loadBackground() {
        let background = SKSpriteNode(texture: SKTexture(image: UIImage(named: "background")!), color: UIColor.clear, size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        background.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
    }
    
    func loadGround() {
        ground = BPGround(size: CGSize(width: self.frame.size.width, height: self.frame.size.height / 2))
        //SKSpriteNode(color: UIColor.gray, size: CGSize(width: self.frame.size.width, height: self.frame.size.height / 2))
        ground.position = CGPoint (x: self.frame.size.width, y: self.frame.size.height / 4)
        addChild(ground)
    }
    
    func loadHero() {
        hero = BPHero()
        hero.position = CGPoint(x: frame.size.width/5, y: frame.size.height / 2 + hero.frame.size.height/2)
        addChild(hero)
    }
    
    func loadGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
        view?.addGestureRecognizer(tapGestureRecognizer)
        
        let rightSwipesGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "rightSwiped")
        rightSwipesGestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        view?.addGestureRecognizer(rightSwipesGestureRecognizer)
        
        let downSwipesGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "downSwiped")
        downSwipesGestureRecognizer.direction = UISwipeGestureRecognizerDirection.down
        view?.addGestureRecognizer(downSwipesGestureRecognizer)
    }
    
    func loadObstacleGenerator() {
        generator = BPObstacleGenerator(size: CGSize(width: frame.size.width, height: frame.size.height/2))
        generator.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 3/4)
        addChild(generator)
    }
    
    func loadPhysicsWorld() {
        physicsWorld.contactDelegate = self // self -> reference to the SKScene!
    }
    
    func loadStartLabel() {
        let tapToStartLabel = SKLabelNode(text: "Tap to start")
        tapToStartLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2 + 60)
        tapToStartLabel.name = "tapToStartLabel"
        addChild(tapToStartLabel)
        
        tapToStartLabel.run(blinkAnimation())
    }
    
    func loadPointsLabel() {
        let pointsLabel = BPPointsLabel(number: 0)
        pointsLabel.position = CGPoint(x: frame.size.width - 15, y: frame.size.height - 31)
        pointsLabel.name = "pointsLabel"
        addChild(pointsLabel)
        
        let defaults = UserDefaults.standard
        let highscore = defaults.integer(forKey: "highscore")
        
        let highscoreLabel = BPPointsLabel(number: highscore)
        highscoreLabel.position = CGPoint(x: frame.size.width - 20, y: frame.size.height - 16)
        highscoreLabel.name = "highscoreLabel"
        addChild(highscoreLabel)
        
    }
    
    func loadBackButton() {
        backButton = BPButton(text: "Back", fillColor: kButtonColor)
        backButton.position = CGPoint(x: 32, y: frame.size.height - 17)
        addChild(backButton)
    }
    /*func loadBackgroundMusic() {
        if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
    }*/
    
    // MARK: Button Action
    func transitionToMenuScene() {
        print("transitionToMenuScene")
        let scene = MenuScene(size: frame.size)
        view!.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
    }

    // MARK: Animations
    func blinkAnimation() -> SKAction {
        let blinkDuration: TimeInterval = 0.5
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: blinkDuration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: blinkDuration)
        let fadeSequence = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(fadeSequence)
    }
    
    
    // MARK: Game Lifecycle
    func start() {
        
        isStarted = true
        
        hero.run()
        generator.startGeneratingObstaclesWithInterval(interval: 1)
        ground.start()
        
        let tapToStartLabel = childNode(withName: "tapToStartLabel")
        tapToStartLabel!.removeFromParent()
    }
    
    func gameOver() {
        
        isGameOver = true
        
        // stop everything
        hero.die()
        ground.stop()
        generator.stop()
        
        // Load Game Over Label
        let gameOverLabel = SKLabelNode(text: "GAME OVER")
        gameOverLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2 + 60)
        addChild(gameOverLabel)
        
        gameOverLabel.run(blinkAnimation())
        
        // Save highscore
        let pointsLabel = childNode(withName: "pointsLabel") as! BPPointsLabel
        let highscoreLabel = childNode(withName: "highscoreLabel") as! BPPointsLabel
        
        if pointsLabel.number > highscoreLabel.number {
            highscoreLabel.setTo(num: pointsLabel.number)
            
            let defaults = UserDefaults.standard
            defaults.set(highscoreLabel.number, forKey: "highscore")
        }
        
    }
    
    func restart() {
        
        let newScene = GameScene(size: view!.frame.size)
        newScene.scaleMode = .aspectFill
        
        view!.presentScene(newScene)
        //view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.5))
        
    }
    
    // MARK : Actions
    /*func tapped() {
        if isGameOver {
            restart()
        } else if !isStarted {
            start()
        } else {
            hero.jump()
        }
    }
    */
    func tapped() {
        if !isStarted && !isGameOver {
            start()
        } else if isStarted && !isGameOver {
            hero.jump()
        } else {
            restart()
        }

    }
    
    func rightSwiped() {
        print("right Swiped")
        hero.slide()
    }
    
    func downSwiped() {
        hero.attack()
        print("down Swiped")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            
            let location = touch.location(in: self)
            if backButton.frame.contains(location) {
                transitionToMenuScene()
            }
        }

       /*
        hero.animateSlide()
        hero.jump()
        hero.attack()
        */
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //if isStarted {
            
            // Track obstacles for when they pass the hero to increase the points label
            if generator.obstacleTrackers.count > 0 {
                
                let currentTracker = generator.obstacleTrackers[0]
                let trackerPositionInScene = self.convert(currentTracker.position, from: generator)
                if trackerPositionInScene.x < hero.position.x {
                    let pointsLabel = childNode(withName: "pointsLabel") as! BPPointsLabel
                    pointsLabel.increment()
                    generator.obstacleTrackers.removeFirst()
                }
            }
            
            // Remove obstacles when they go off scene
            if generator.obstacles.count > 0 {
                
                let currentObstacle = generator.obstacles[0]
                let obstaclePostitionInScene = convert(currentObstacle.position, from: generator)
                if obstaclePostitionInScene.x < -frame.size.width/2 {
                    generator.obstacles.removeFirst()
                    currentObstacle.removeFromParent()
                }
            }
        
        
        
        /*if generator.obstacles.count > 0 {
            
            let obstacle = generator.obstacles[0] as BPObstacle
            
            let obstacleLocation = generator.convert(obstacle.position, to: self)
            if obstacleLocation.x < hero.position.x {
                generator.obstacles.remove(at: 0)
                
                let pointsLabel = childNode(withName: "pointsLabel") as! ////
            }
        }
 */
    }
    
    //MARK: SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
 
        if contact.bodyA.categoryBitMask == attackObstacleCategory {
            
            if hero.isAttacking {
                let attackObstacle = contact.bodyA.node as! BPAttackObstacle
                attackObstacle.explode()
            } else {
                gameOver()
            }
            
        } else if contact.bodyB.categoryBitMask == attackObstacleCategory {
            
            if hero.isAttacking {
                let attackObstacle = contact.bodyB.node as! BPAttackObstacle
                attackObstacle.explode()
            } else {
                gameOver()
            }
        
        } else if !isGameOver {
            gameOver()
        }
        
    }
}
