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
  
  var scene: GameScene!
  var level: Level!
    var LevelNumber = 1
    var movesLeft = 0
    var score = 0
    var tapGestureRecognizer: UITapGestureRecognizer!
    var completed = false
    var gameOverMessage = "Game Over"
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var resetPuzzleButton: UIButton!
    
  
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
        
    let skView = view as! SKView
    skView.isMultipleTouchEnabled = false
    
    print(LevelNumber)
    
    gameOverLabel.isHidden = true
    resetPuzzleButton.isHidden = true
    
    self.view?.backgroundColor = UIColor.white

    scene = GameScene(size: skView.bounds.size)
    scene.scaleMode = .aspectFill
    
    var fileName = "Level_\(LevelNumber)"
    
    level = Level(filename: fileName)
    scene.level = level
    
    print(fileName)
    scene.swipeHandler = handleSwipe
    
    skView.presentScene(scene)
    
    beginGame()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        gameOverLabel.isHidden = true
        resetPuzzleButton.isHidden = true
        
        self.view?.backgroundColor = UIColor.white
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        var fileName = "Level_\(LevelNumber)"
        
        level = Level(filename: fileName)
        scene.level = level
        
        scene.swipeHandler = handleSwipe
        
        skView.presentScene(scene)
        
        beginGame()
    }
  
  func beginGame() {
    movesLeft = level.maximumMoves
    movesLabel.isHidden = false
    resetPuzzleButton.isHidden = true
    updateLabels()
    scene.gameLayer.alpha = 1
    scene.isUserInteractionEnabled = true
    shuffle()
  }
  
  func shuffle() {
    let newShapes = level.shuffle()
    scene.addSprites(for: newShapes)
  }
    
    func handleSwipe(swap: Swap) {
        view.isUserInteractionEnabled = false
        
        level.performSwap(swap: swap)
        
        if(level.completed == true){
            gameOverLabel.text = "Complete"
            resetPuzzleButton.setTitle("Next Puzzle", for: UIControlState.normal)
            gameOverLabel.isHidden = false
            scene.gameLayer.alpha = 0.2
            scene.isUserInteractionEnabled = false
            resetPuzzleButton.isHidden = false
            movesLabel.isHidden = true
        }
        
        scene.animate(swap) {
            self.view.isUserInteractionEnabled = true
        }
        
        movesLeft = movesLeft-1
        updateLabels()
        
        if(movesLeft==0 && level.completed != true){
            gameOverLabel.text = "Please try again"
            gameOverLabel.isHidden = false
            scene.gameLayer.alpha = 0.2
            scene.isUserInteractionEnabled = false
            resetPuzzleButton.isHidden = false
            movesLabel.isHidden = true
            }
    }
  
    func updateLabels() {
        movesLabel.text = String(format: "Moves left: "+"%ld", movesLeft)
        levelLabel.text = String(format: "Level "+"%ld", LevelNumber)
    }
    
    
    func success(){
        movesLabel.text = "Completed"
    }
    @IBAction func tapResetButton(_ sender: Any) {
        viewWillAppear(true)
    }
    
    
}
