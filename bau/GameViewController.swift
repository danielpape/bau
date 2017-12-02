//
//  GameViewController.swift
//  ShapeCrunch
//
//  Created by Razeware on 13/04/16.
//  Copyright (c) 2016 Razeware LLC. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  // MARK: Properties
  
  // The scene draws the tiles and shape sprites, and handles swipes.
  var scene: GameScene!
  
  // The level contains the tiles, the shapes, and most of the gameplay logic.
  // Needs to be ! because it's not set in init() but in viewDidLoad().
  var level: Level!
  
  
  // MARK: View Controller Functions
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return [.portrait, .portraitUpsideDown]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure the view.
    let skView = view as! SKView
    skView.isMultipleTouchEnabled = false
    
    self.view?.backgroundColor = UIColor.white

    
    // Create and configure the scene.
    scene = GameScene(size: skView.bounds.size)
    scene.scaleMode = .aspectFill
    
    // Load the level.
    level = Level(filename: "Level_1")
    scene.level = level
    
    scene.swipeHandler = handleSwipe
    
    // Present the scene.
    skView.presentScene(scene)
    
    // Start the game.
    beginGame()
  }
  
  
  // MARK: Game functions
  
  func beginGame() {
    shuffle()
  }
  
  func shuffle() {
    // Fill up the level with new shapes, and create sprites for them.
    let newShapes = level.shuffle()
    scene.addSprites(for: newShapes)
  }
    
    func handleSwipe(swap: Swap) {
        view.isUserInteractionEnabled = false
        
        level.performSwap(swap: swap)
        
        scene.animate(swap) {
            self.view.isUserInteractionEnabled = true
        }
    }
  
}
