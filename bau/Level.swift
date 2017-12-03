//
//  Level.swift
//  ShapeCrunch
//
//  Created by Razeware on 13/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation

let NumColumns = 3
let NumRows = 3

class Level {
    var maximumMoves = 0
    var startingShapes:Array = [0,0]
    let tilesArray = [ [1, 1, 1,],
                       [1, 1, 1,],
                       [1, 1, 1,], ]
    
  var completed = false
    fileprivate var shapes = Array2D<Shape>(columns: 3, rows: 3)
    fileprivate var tiles = Array2D<Tile>(columns: 3, rows: 3)

  init(filename: String) {
    guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else { return }
//    guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
    
    maximumMoves = dictionary["moves"] as! Int
    startingShapes = dictionary["shapes"] as! Array
    
    for (row, rowArray) in tilesArray.enumerated() {
      let tileRow = NumRows - row - 1
        for (column, value) in rowArray.enumerated() {
          tiles[column, tileRow] = Tile()
      }
    }
  }
  
  
  // MARK: Level Setup
  
  // Fills up the level with new Shape objects
  func shuffle() -> Set<Shape> {
    return createInitialShapes()
  }
  
  fileprivate func createInitialShapes() -> Set<Shape> {
    var set = Set<Shape>()
    
    let shapeArray = [1,2,4,3,5,6,8,7,9]
    var arrayPosition:Int = 0
    
    for row in 0..<3 {
      for column in 0..<3 {
        if tiles[column, row] != nil {
            
          let shapeType = startingShapes[arrayPosition]
            arrayPosition = arrayPosition + 1
          
            let shape = Shape(column: column, row: row, shapeType: ShapeType(rawValue: shapeType)!)
          shapes[column, row] = shape
          
          set.insert(shape)
        }
      }
    }
    return set
  }
  
  
  // MARK: Query the level
  
  // Determines whether there's a tile at the specified column and row.
  func tileAt(column: Int, row: Int) -> Tile? {
    assert(column >= 0 && column < 3)
    assert(row >= 0 && row < 3)
    return tiles[column, row]
  }
  
  // Returns the shape at the specified column and row, or nil when there is none.
  func shapeAt(column: Int, row: Int) -> Shape? {
    assert(column >= 0 && column < 3)
    assert(row >= 0 && row < 3)
    return shapes[column, row]
  }
    
    func performSwap(swap: Swap) {
        let columnA = swap.shapeA.column
        let rowA = swap.shapeA.row
        let columnB = swap.shapeB.column
        let rowB = swap.shapeB.row
        
        shapes[columnA, rowA] = swap.shapeB
        swap.shapeB.column = columnA
        swap.shapeB.row = rowA
        
        shapes[columnB, rowB] = swap.shapeA
        swap.shapeA.column = columnB
        swap.shapeA.row = rowB
        
        detectHorizontalMatches()
        
    }
    
    func detectHorizontalMatches() {
var shapeArray: [String] = []
        for row in 0..<NumRows {
            var column = 0
            while column < NumColumns {
                shapeArray.append(shapeAt(column: column, row: row)!.description)
                column += 1
            }
        }
        detectCompletedBoard(currentState: shapeArray)
    }
    
    func detectCompletedBoard(currentState: Array<String>){
        let completedStates:Array = [
            ["bluSqu", "redSqu", "yelSqu", "bluTri", "redTri", "yelTri", "bluCir", "redCir", "yelCir"],
            ["bluSqu", "yelSqu", "redSqu", "bluTri", "yelTri", "redTri", "bluCir", "yelCir", "redCir"],
            ["yelSqu", "bluSqu", "redSqu", "yelTri", "bluTri", "redTri", "yelCir", "bluCir", "redCir"],
            ["yelSqu", "redSqu", "bluSqu", "yelTri", "redTri", "bluTri", "yelCir", "redCir", "bluCir"],
            ["redSqu", "yelSqu", "bluSqu", "redTri", "yelTri", "bluTri", "redCir", "yelCir", "bluCir"],
            ["redSqu", "bluSqu", "yelSqu", "redTri", "bluTri", "yelTri", "redCir", "bluCir", "yelCir"],
            ["bluSqu", "redSqu", "yelSqu", "bluCir", "redCir", "yelCir", "bluTri", "redTri", "yelTri"],
            ["bluSqu", "yelSqu", "redSqu", "bluCir", "yelCir", "redCir", "bluTri", "yelTri", "redTri"],
            ["yelSqu", "bluSqu", "redSqu", "yelCir", "bluCir", "redCir", "yelTri", "bluTri", "redTri"],
            ["yelSqu", "redSqu", "bluSqu", "yelCir", "redCir", "bluCir", "yelTri", "redTri", "bluTri"],
            ["redSqu", "yelSqu", "bluSqu", "redCir", "yelCir", "bluCir", "redTri", "yelTri", "bluTri"],
            ["redSqu", "bluSqu", "yelSqu", "redCir", "bluCir", "yelCir", "redTri", "bluTri", "yelTri"],
            ["bluTri", "redTri", "yelTri", "bluCir", "redCir", "yelCir", "bluSqu", "redSqu", "yelSqu"],
            ["bluTri", "redTri", "yelTri", "bluSqu", "redSqu", "yelSqu", "bluCir", "redCir", "yelCir"],
            ["yelTri", "bluTri", "redTri", "yelSqu", "bluSqu", "redSqu", "yelCir", "bluCir", "redCir"],
            ["yelTri", "bluTri", "redTri", "yelCir", "bluCir", "redCir", "yelSqu", "bluSqu", "redSqu"],
            ["redTri", "bluTri", "yelTri", "redSqu", "bluSqu", "yelSqu", "redCir", "bluCir", "yelCir"],
            ["redTri", "bluTri", "yelTri", "redCir", "bluCir", "yelCir", "redSqu", "bluSqu", "yelSqu"],
            ["yelTri", "yelSqu", "yelCir", "redTri", "redSqu", "redCir", "bluTri", "bluSqu", "bluCir"],
            ["redTri", "redSqu", "redCir", "yelTri", "yelSqu", "yelCir", "bluTri", "bluSqu", "bluCir"],
            ["redTri", "redSqu", "redCir", "bluTri", "bluSqu", "bluCir", "yelTri", "yelSqu", "yelCir"],
            ["bluTri", "bluSqu", "bluCir", "redTri", "redSqu", "redCir", "yelTri", "yelSqu", "yelCir"],
            ["bluTri", "bluSqu", "bluCir", "yelTri", "yelSqu", "yelCir", "redTri", "redSqu", "redCir"],
            ["redTri", "redSqu", "redCir", "bluTri", "bluSqu", "bluCir", "yelTri", "yelSqu", "yelCir"],
            ["redTri", "redSqu", "redCir", "yelTri", "yelSqu", "yelCir", "bluTri", "bluSqu", "bluCir"],
            ["redTri", "redCir", "redSqu", "yelTri", "yelCir", "yelSqu", "bluTri", "bluCir", "bluSqu"],
            ["redCir", "redTri", "redSqu", "yelCir", "yelTri", "yelSqu", "bluCir", "bluTri", "bluSqu"],
            ["redCir", "redSqu", "redTri", "yelCir", "yelSqu", "yelTri", "bluCir", "bluSqu", "bluTri"],
            ["redSqu", "redCir", "redTri", "yelSqu", "yelCir", "yelTri", "bluSqu", "bluCir", "bluTri"],
            ["redSqu", "redTri", "redCir", "yelSqu", "yelTri", "yelCir", "bluSqu", "bluTri", "bluCir"],
            ["yelSqu", "yelTri", "yelCir", "redSqu", "redTri", "redCir", "bluSqu", "bluTri", "bluCir"],
            ["yelSqu", "yelCir", "yelTri", "redSqu", "redCir", "redTri", "bluSqu", "bluCir", "bluTri"],
            ["yelTri", "yelSqu", "yelCir", "redTri", "redSqu", "redCir", "bluTri", "bluSqu", "bluCir"],
            ["yelTri", "yelCir", "yelSqu", "redTri", "redCir", "redSqu", "bluTri", "bluCir", "bluSqu"],
            ["bluTri", "bluCir", "bluSqu", "yelTri", "yelCir", "yelSqu", "redTri", "redCir", "redSqu"],
            ["bluSqu", "bluTri", "bluCir", "yelSqu", "yelTri", "yelCir", "redSqu", "redTri", "redCir"],
            ["bluSqu", "bluCir", "bluTri", "yelSqu", "yelCir", "yelTri", "redSqu", "redCir", "redTri"]
]
        
        for completedState:Array in completedStates{
            if currentState == completedState{
                completed = true
            }
            
        }
    }
    
  
}
