//
//  BoardModel.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 19/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import Foundation

enum BoardError: Error {
    
    case invalidMove
    
}

class BoardModel{
    
    
    var publicBoard: [[Piece?]] {
        get {
            return board
        }
    }
    private var board: [[Piece?]]
    var delegate: BoardDelegate?
    
    init() {
        
        board = BoardModel.defaultBoard()
        
    }
    
    func movePiece(from oldPosition: (Int, Int), to newPosition: (Int, Int)) throws {
        
        if (moveAllowed(from: oldPosition, to: newPosition)) {
            
            if let piece = board[newPosition.0][newPosition.1] {
                
                delegate?.pieceCaptured(piece: piece)
                
            }
            
            board[newPosition.0][newPosition.1] = board[newPosition.0][newPosition.1]
            board[oldPosition.0][oldPosition.1] = nil
            
        } else {
            
            throw BoardError.invalidMove
            
        }
        
    }
    
    
    private static func defaultBoard() -> [[Piece?]] {
        
        var defBoard = [[Piece?]](repeatElement([Piece?](repeatElement(nil, count: 8)), count: 8));
        
        // Fill the rows with pawns
        defBoard[1] = [Piece](repeating: Piece.init(pieceType: .pawn, pieceColor: .black), count: 8)
        defBoard[6] = [Piece](repeating: Piece.init(pieceType: .pawn, pieceColor: .white), count: 8)
        
        for i in 0...1 {
            
            let s = i * 3
            
            for j in 0...3 {
                
                let k = j - s
                if (k == -3 || k == 3) {
                    // Fill the first and last row of the board
                    defBoard[0][(4 * i + j)] = Piece.init(pieceType: PieceType(rawValue: k)!, pieceColor: .black)
                    defBoard[7][(4 * i + j)] = Piece.init(pieceType: PieceType(rawValue: -k)!, pieceColor: .white)
                } else {
                    defBoard[0][(4 * i + j)] = Piece.init(pieceType: PieceType(rawValue: abs(k))!, pieceColor: .black)
                    defBoard[7][(4 * i + j)] = Piece.init(pieceType: PieceType(rawValue: abs(k))!, pieceColor: .white)
                }
                
            }
            
        }
        
        return defBoard
    }
    
    func moveAllowed(from oldPos: (Int, Int), to newPos: (Int, Int)) -> Bool {
        
        let optPiece = board[oldPos.0][oldPos.1]
        
        
        if ((max(newPos.0, newPos.1) > 8) || (min(newPos.0, newPos.1) < 0)) {
            return false
        }
        
        let diff = (abs(newPos.0 - oldPos.0), abs(newPos.1 - oldPos.1))
        
        if let piece = optPiece {
            
            // Logic checking if there are any pieces between oldPos and newPos, EXCLUDES THE ENDPOINT
            let pathClear = !piecesBetween(position1: oldPos, position2: newPos)
            
            var capturesPiece = false
            
            // Check if the endpoint contains a piece of the same color, if so, dont allow the move
            if (board[newPos.0][newPos.1]?.color == piece.color) {
                
                return false
                
            }
                // If the endpoint is not empty and its not of the same color as current piece, we know that the endpoint is gonna be captured
            else if (board[newPos.0][newPos.1] != nil) {
                
                capturesPiece = true
                
            }
            
            switch piece.piece {
                
            case .pawn:
                if ((diff.0 == 0) && (diff.1 == 1)) {
                    return true
                } else if (diff.1 == 2 && pathClear) { // Starting position double move
                    // Check if position is a starting pos for a pawn
                    if (oldPos.0 == 1 || oldPos.0 == 7) {
                        return true
                    }
                } else if (diff.1 == 1 && (diff.0 == diff.1) && capturesPiece) { // If the pawn captures a piece at the end, allow it to move diagonally
                    return true
                }
            case .bishop:
                if (diff.0 == diff.1 && pathClear) {
                    return true
                }
            case .king:
                if (max(diff.0, diff.1) == 1) {
                    return true
                }
            case .knight:
                break
            case .queen:
                if (((diff.0 == diff.1) || min(diff.0, diff.1) == 0) && pathClear) {
                    return true
                }
            case .rook:
                if (min(diff.0, diff.1) == 0 && pathClear) {
                    return true
                }
            }
            
            
            
        }
        
        return false
    }
    
    private func piecesBetween(position1: (Int, Int), position2: (Int, Int)) -> Bool {
        
        
        let diff = (abs(position1.0 - position2.0), abs(position1.1 - position2.1))
        
        // The case where the movement is purely horizontal
        if (diff.1 == 0) {
            
            for i in (position1.0 + 1)..<position2.0 {
                
                if (board[i][position2.1] != nil) {
                    return true
                }
                
            }
            
        } else if (diff.0 == 0) { // The case where the movement is purely vertical
            
            for i in (position1.1 + 1)..<position2.1 {
                
                if (board[position2.0][i] != nil) {
                    
                    return true
                    
                }
                
            }
            
        } else if (diff.0 == diff.1) { // The case where the movement is diagonal
            
            for i in (position1.0 + 1)..<position2.0 {
                
                if (board[i][i] != nil) {
                    
                    return true
                    
                }
                
            }
            
            
        }
        
        
        return false
    }
    
}
