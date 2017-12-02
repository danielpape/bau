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
    case unknown = 0, redSqu, bluSqu, yelSqu, redTri, bluTri, yelTri, redCir, bluCir, yelCirc
    
    var spriteName: String {
        let spriteNames = [
            "redSqu",
            "bluSqu",
            "yelSqu",
            "redTri",
            "bluTri",
            "yelTri",
            "redCir",
            "bluCir",
            "yelCir"]
    
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
    return "\(shapeType)"
  }
  
  var hashValue: Int {
    return row*10 + column
  }
  
}
