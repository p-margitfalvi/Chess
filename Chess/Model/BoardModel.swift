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
    
    // TODO: Optimize by letting the subarray be an optional as well, so if a row is empty it is skipped in loops
    private var board: [[Piece?]]
    var delegate: BoardModelDelegate?
    
    init() {
        
        board = BoardModel.defaultBoard()
        
    }
    
    func movePiece(from oldPosition: (x: Int, y: Int), to newPosition: (x: Int, y: Int)) throws {
        
        // REMOVE THE LAST || true IF YOU WANT THIS TO WORK
        if (moveAllowed(from: oldPosition, to: newPosition) || true) {
            
            if let piece = board[newPosition.y][newPosition.x] {
                
                //delegate?.pieceCaptured()
                
            }
            
            delegate?.pieceMoved(from: oldPosition, to: newPosition)
            board[newPosition.y][newPosition.x] = board[newPosition.y][newPosition.x]
            board[oldPosition.y][oldPosition.x] = nil
            
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
    
    func moveAllowed(from oldPos: (x: Int, y: Int), to newPos: (x: Int, y: Int)) -> Bool {
        
        let optPiece = board[oldPos.y][oldPos.x]
        
        
        if ((max(newPos.y, newPos.x) > 8) || (min(newPos.y, newPos.x) < 0)) {
            return false
        }
        
        let diff = (y: abs(newPos.y - oldPos.y), x: abs(newPos.x - oldPos.x))
        
        if let piece = optPiece {
            
            // Logic checking if there are any pieces between oldPos and newPos, EXCLUDES THE ENDPOINT
            let pathClear = !piecesBetween(position1: oldPos, position2: newPos)
            
            var capturesPiece = false
            
            // Check if the endpoint contains a piece of the same color, if so, dont allow the move
            if (board[newPos.y][newPos.x]?.color == piece.color) {
                
                return false
                
            }
                // If the endpoint is not empty and its not of the same color as current piece, we know that the endpoint is gonna be captured
            else if (board[newPos.y][newPos.x] != nil) {
                
                capturesPiece = true
                
            }
            
            switch piece.type {
                
            case .pawn:
                if ((diff.x == 0) && (diff.y == 1)) {
                    return true
                } else if (diff.x == 2 && pathClear) { // Starting position double move
                    // Check if position is a starting pos for a pawn
                    if (oldPos.x == 1 || oldPos.x == 7) {
                        return true
                    }
                } else if (diff.y == 1 && (diff.x == diff.y) && capturesPiece) { // If the pawn captures a piece at the end, allow it to move diagonally
                    return true
                }
            case .bishop:
                if (diff.x == diff.y && pathClear) {
                    return true
                }
            case .king:
                if (max(diff.x, diff.y) == 1) {
                    return true
                }
            case .knight:
                break
            case .queen:
                if (((diff.x == diff.y) || min(diff.x, diff.y) == 0) && pathClear) {
                    return true
                }
            case .rook:
                if (min(diff.x, diff.y) == 0 && pathClear) {
                    return true
                }
            }
            
            
            
        }
        
        return false
    }
    
    private func piecesBetween(position1: (x: Int, y: Int), position2: (x: Int, y: Int)) -> Bool {
        
        
        let diff = (y: abs(position1.y - position2.y), x: abs(position1.x - position2.x))
        
        // The case where the movement is purely horizontal
        if (diff.x == 0) {
            
            for i in (position1.x + 1)..<position2.x {
                
                if (board[i][position2.x] != nil) {
                    return true
                }
                
            }
            
        } else if (diff.y == 0) { // The case where the movement is purely vertical
            
            for i in (position1.x + 1)..<position2.x {
                
                if (board[position2.y][i] != nil) {
                    
                    return true
                    
                }
                
            }
            
        } else if (diff.x == diff.y) { // The case where the movement is diagonal
            
            for i in (position1.y + 1)..<position2.y {
                
                if (board[i][i] != nil) {
                    
                    return true
                    
                }
                
            }
            
            
        }
        
        
        return false
    }
    
}
