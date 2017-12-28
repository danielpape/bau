//
//  GameScene.swift
//  ShapeCrunch
//
//  Created by Razeware on 13/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var swipeFromColumn: Int?
    private var swipeFromRow: Int?
  
  var level: Level!
    var swipeHandler: ((Swap) -> ())?
  
  let TileWidth: CGFloat = 95.0
  let TileHeight: CGFloat = 96.0
  
  let gameLayer = SKNode()
  let shapesLayer = SKNode()
  let tilesLayer = SKNode()

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder) is not used in this app")
  }
  
  override init(size: CGSize) {
    super.init(size: size)
    
    anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    let background = SKSpriteNode(imageNamed: "Background")
    background.size = size
    addChild(background)
    
    addChild(gameLayer)
    
    let layerPosition = CGPoint(
      x: -TileWidth * CGFloat(NumColumns) / 2,
      y: -TileHeight * CGFloat(NumRows) / 2)
    
    tilesLayer.position = layerPosition
    gameLayer.addChild(tilesLayer)
    
    shapesLayer.position = layerPosition
    gameLayer.addChild(shapesLayer)
    
    swipeFromColumn = nil
    swipeFromRow = nil
  }
  
  func addTiles() {
    for row in 0..<NumRows {
      for column in 0..<NumColumns {
        if level.tileAt(column: column, row: row) != nil {
           let tileNode = SKSpriteNode(imageNamed: "Tile")
          tileNode.size = CGSize(width: TileWidth, height: TileHeight)
          tileNode.position = pointFor(column: column, row: row)
          tilesLayer.addChild(tileNode)
        }
      }
    }
  }

  func addSprites(for shapes: Set<Shape>) {
    for shape in shapes {
      // Create a new sprite for the shape and add it to the shapesLayer.
      let sprite = SKSpriteNode(imageNamed: shape.shapeType.spriteName)
      sprite.size = CGSize(width: TileWidth, height: TileHeight)
      sprite.position = pointFor(column: shape.column, row: shape.row)
      shapesLayer.addChild(sprite)
      shape.sprite = sprite
    }
  }
  
  
  // MARK: Point conversion
  
  // Converts a column,row pair into a CGPoint that is relative to the shapeLayer.
  func pointFor(column: Int, row: Int) -> CGPoint {
    return CGPoint(
      x: CGFloat(column)*TileWidth + TileWidth/2,
      y: CGFloat(row)*TileHeight + TileHeight/2)
  }
    
    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileWidth &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileHeight {
            return (true, Int(point.x / TileWidth), Int(point.y / TileHeight))
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1
        guard let touch = touches.first else { return }
        let location = touch.location(in: shapesLayer)
        // 2
        let (success, column, row) = convertPoint(point:location)
        if success {
            // 3
            if let shape = level.shapeAt(column: column, row: row) {
                // 4
                swipeFromColumn = column
                swipeFromRow = row
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1
        guard swipeFromColumn != nil else { return }
        
        // 2
        guard let touch = touches.first else { return }
        let location = touch.location(in: shapesLayer)
        
        let (success, column, row) = convertPoint(point:location)
        if success {
            
            // 3
            var horzDelta = 0, vertDelta = 0
            if column < swipeFromColumn! {          // swipe left
                horzDelta = -1
            } else if column > swipeFromColumn! {   // swipe right
                horzDelta = 1
            } else if row < swipeFromRow! {         // swipe down
                vertDelta = -1
            } else if row > swipeFromRow! {         // swipe up
                vertDelta = 1
            }
            
            // 4
            if horzDelta != 0 || vertDelta != 0 {
                trySwap(horizontal: horzDelta, vertical: vertDelta)
                
                // 5
                swipeFromColumn = nil
            }
        }
    }
    
    func trySwap(horizontal horzDelta: Int, vertical vertDelta: Int) {
        // 1
        let toColumn = swipeFromColumn! + horzDelta
        let toRow = swipeFromRow! + vertDelta
        // 2
        guard toColumn >= 0 && toColumn < NumColumns else { return }
        guard toRow >= 0 && toRow < NumRows else { return }
        // 3
        if let toShape = level.shapeAt(column: toColumn, row: toRow),
            let fromShape = level.shapeAt(column: swipeFromColumn!, row: swipeFromRow!) {
            // 4
            if let handler = swipeHandler {
                let swap = Swap(shapeA: fromShape, shapeB: toShape)
                handler(swap)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipeFromColumn = nil
        swipeFromRow = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    func animate(_ swap: Swap, completion: @escaping () -> ()) {
        let spriteA = swap.shapeA.sprite!
        let spriteB = swap.shapeB.sprite!
        
        spriteA.zPosition = 100
        spriteB.zPosition = 90
        
        let duration: TimeInterval = 0.16
        
        let moveA = SKAction.move(to: spriteB.position, duration: duration)
        moveA.timingMode = .easeInEaseOut
        spriteA.run(moveA, completion: completion)
        
        let moveB = SKAction.move(to: spriteA.position, duration: duration)
        moveB.timingMode = .easeInEaseOut
        spriteB.run(moveB)
    }

}









