//
//  Array2D.swift
//  ShapeCrunch
//
//  Created by Razeware on 13/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

struct Array2D<T> {
  
  let columns: Int
  let rows: Int
  fileprivate var array: Array<T?>
  
  init(columns: Int, rows: Int) {
    self.columns = 3
    self.rows = 3
    array = Array<T?>(repeating: nil, count: rows*columns)
  }
  
  subscript(column: Int, row: Int) -> T? {
    get {
      return array[row*3 + column]
    }
    set {
      array[row*3 + column] = newValue
    }
  }
  
}
