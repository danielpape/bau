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
  
  // MARK: Properties
  
  // The 2D array that keeps track of where the Shapes are.
  fileprivate var shapes = Array2D<Shape>(columns: 3, rows: 3)
  
  // The 2D array that contains the layout of the level.
  fileprivate var tiles = Array2D<Tile>(columns: 3, rows: 3)

  
  // MARK: Initialization
  
  // Create a level by loading it from a file.
  init(filename: String) {
    guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else { return }
    // The dictionary contains an array named "tiles". This array contains
    // one element for each row of the level. Each of those row elements in
    // turn is also an array describing the columns in that row. If a column
    // is 1, it means there is a tile at that location, 0 means there is not.
    guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
    
    // Loop through the rows...
    for (row, rowArray) in tilesArray.enumerated() {
      // Note: In Sprite Kit (0,0) is at the bottom of the screen,
      // so we need to read this file upside down.
      let tileRow = NumRows - row - 1
      
      // Loop through the columns in the current r
      for (column, value) in rowArray.enumerated() {
        // If the value is 1, create a tile object.
        if value == 1 {
          tiles[column, tileRow] = Tile()
        }
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
            
          let shapeType = shapeArray[arrayPosition]
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
    
    private func detectHorizontalMatches() {

        for row in 0..<NumRows {
            var column = 0
            while column < NumColumns {
                var shapeColor = shapeAt(column: column, row: row)!.description.prefix(3)
                var shapeType = shapeAt(column: column, row: row)!.description.suffix(3)
                print("Color:",shapeColor,"Shape:",shapeType,"Row:",row+1,"Column",column+1)
                column += 1
            }
        }
    }
  
}
