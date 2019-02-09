//
//  GameViewController.swift
//  CasualMode2
//
//  Created by Stanimir on 9/16/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        authenticateLocalPlayer()
        
        //Configure the view
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimization to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        let scene = MenuScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
        /*if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
 */
    }
    
    func authenticateLocalPlayer() {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if viewController != nil {
                self.present(viewController!, animated: true, completion: nil)
            }
            
            else {
                print("User is authenticated: \(GKLocalPlayer.localPlayer().isAuthenticated)")
            }
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
