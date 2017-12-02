//
//  Shape.swift
//  ShapeCrunch
//
//  Created by Razeware on 13/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import SpriteKit

// MARK: - ShapeType

enum ShapeType: Int, CustomStringConvertible {
    case unknown = 0, redSquare, blueSquare, yellowSquare, redTriangle, blueTriangle, yellowTriangle, redCircle, blueCircle, yellowCircle
    
    var spriteName: String {
        let spriteNames = [
            "redSquare",
            "blueSquare",
            "yellowSquare",
            "redTriangle",
            "blueTriangle",
            "yellowTriangle",
            "redCircle",
            "blueCircle",
            "yellowCircle"]
    
    return spriteNames[rawValue - 1]
  }
  
  var highlightedSpriteName: String {
    return spriteName + "-Highlighted"
  }
  
  var description: String {
    return spriteName
  }
  
  static func random() -> ShapeType {
    return ShapeType(rawValue: Int(arc4random_uniform(9)) + 1)!
  }
}


// MARK: - Shape

func ==(lhs: Shape, rhs: Shape) -> Bool {
  return lhs.column == rhs.column && lhs.row == rhs.row
}

class Shape: CustomStringConvertible, Hashable {
  
  var column: Int
  var row: Int
  let shapeType: ShapeType
  var sprite: SKSpriteNode?
  
  init(column: Int, row: Int, shapeType: ShapeType) {
    self.column = column
    self.row = row
    self.shapeType = shapeType
  }
  
  var description: String {
    return "type:\(shapeType) square:(\(column),\(row))"
  }
  
  var hashValue: Int {
    return row*10 + column
  }
  
}
