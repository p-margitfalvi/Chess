//
//  BoardModelDelegate.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 31/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import Foundation

protocol BoardModelDelegate {
    
    func pieceMoved(from oldCoords: (x: Int, y: Int), to newCoords: (x: Int, y: Int))
    
}
