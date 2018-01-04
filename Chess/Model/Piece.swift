//
//  Piece.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 19/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import Foundation

enum PieceType: Int {
    
    case rook = 0
    case knight
    case bishop
    case queen = 3
    case king = -3
    case pawn = 8
    
}

enum PieceColor: Int {
    
    case black = 0
    case white
    
}


class Piece {
    
    var piece: PieceType
    var color: PieceColor
    
    init(pieceType: PieceType, pieceColor: PieceColor) {
        
        piece = pieceType
        color = pieceColor
        
    }
    

    
}
