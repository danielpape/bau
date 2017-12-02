//
//  Swap.swift
//  bau
//
//  Created by Daniel Pape on 02/12/2017.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

struct Swap: CustomStringConvertible {
    let shapeA: Shape
    let shapeB: Shape
    
    init(shapeA: Shape, shapeB: Shape) {
        self.shapeA = shapeA
        self.shapeB = shapeB
        
    }
    
    var description: String {
        return "swap \(shapeA) with \(shapeB)"
    }
}
