//
//  ViewController.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 18/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, BoardModelDelegate {
    
    let board = BoardModel()
    @IBOutlet weak var boardView: BoardView!
    
    var gestureRecognizer: UITapGestureRecognizer!
    var selectedPiece: (indices: (x: Int, y: Int), view: PieceView)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        board.delegate = self
        
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.squareTouched))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        boardView.addGestureRecognizer(gestureRecognizer)
        
        // Initial setup of the default board
        for (yIdx, column) in board.publicBoard.enumerated() {
            
            for (xIdx, row) in column.enumerated() {
                
                if let piece = row {
                    
                    let viewRect = mapCoords(coords: (xIdx, yIdx))
                    var color: UIColor!
                    
                    switch piece.color {
                    case .black:
                        color = UIColor.black
                    case .white:
                        color = UIColor.white
                    }
                    
                    let view = PieceView(pieceColor: color, frame: viewRect)
                    
                    view.image = imageFor(pieceType: piece.type, color: piece.color)
                    view.isUserInteractionEnabled = true
                    
                    view.contentMode = .redraw
                    boardView.addSubview(view)
                }
                
                
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pieceMoved(from oldCoords: (x: Int, y: Int), to newCoords: (x: Int, y: Int)) {
        
        if let view = pieceView(atIndices: oldCoords) {
            
            view.frame = mapCoords(coords: newCoords)
            view.setNeedsDisplay()
            
        }
        
    }
    
    func pieceCaptured(at position: (x: Int, y: Int)) {
        
        if let view = pieceView(atIndices: position) {
            
            view.removeFromSuperview()
            
        }
        
    }
    
    @objc func squareTouched(sender: UITapGestureRecognizer) {
        
        let locationTouched = sender.location(in: boardView)
        let squareTouched = mapCoords(point: locationTouched)
        
        if let oldPiece = selectedPiece {
            
            // Add code for the case that if a move is impossible it should just select another piece
            do {
                try board.movePiece(from: oldPiece.indices, to: squareTouched)
            } catch {
                print("Invalid move")
            }
            
            selectedPiece = nil
            
        } else {
            
            if let piece = pieceView(atIndices: squareTouched) {
                
                selectedPiece = (squareTouched, piece)
            }
            
        }
        
    }
    
    private func pieceView(atIndices coords: (x: Int, y: Int)) -> PieceView? {
        
        let viewRect = mapCoords(coords: coords)
        let midpoint = CGPoint(x: viewRect.midX, y: viewRect.midY)
        
        for view in boardView.subviews {
            
            if view.frame.contains(midpoint) {
                
                if let pieceView = view as? PieceView {
                    
                    return pieceView
                }
                
            }
            
        }
        
        return nil
    }
    
    private func mapCoords(point: CGPoint) -> (x: Int, y: Int) {
        
        let xCoord = Int((point.x - boardView.edgeOffset - boardView.borderSize) / boardView.inlineSquareSize)
        let yCoord = Int((point.y - boardView.edgeOffset - boardView.borderSize) / boardView.inlineSquareSize)
        
        return (xCoord, yCoord)
        
    }
    
    private func mapCoords(frame: CGRect) -> (x: Int, y: Int) {
        
        // Just used the reversed equation from map coords
        let xCoord = Int((frame.midX - boardView.edgeOffset - boardView.borderSize) / boardView.inlineSquareSize)
        let yCoord = Int((frame.midY - boardView.edgeOffset - boardView.borderSize) / boardView.inlineSquareSize)
        
        return (xCoord, yCoord)
    }
    
    private func mapCoords(coords: (x: Int, y: Int)) -> CGRect {
        
        let xPoint = CGFloat(coords.x) * boardView.inlineSquareSize + boardView.edgeOffset + boardView.borderSize
        let yPoint = CGFloat(coords.y) * boardView.inlineSquareSize + boardView.edgeOffset + boardView.borderSize
        
        return CGRect(x: xPoint, y: yPoint, width: boardView.inlineSquareSize, height: boardView.inlineSquareSize)
        
    }
    
    private func imageFor(pieceType: PieceType, color: PieceColor) -> UIImage {
        
        
        var fileName = "piece_"
        
        switch color {
        case .black:
            fileName += "black_"
        case .white:
            fileName += "white_"
        }
        
        switch pieceType {
        case .bishop:
            fileName += "bishop"
        case .king:
            fileName += "king"
        case .knight:
            fileName += "knight"
        case .pawn:
            fileName += "pawn"
        case.queen:
            fileName += "queen"
        case .rook:
            fileName += "rook"
        }
        
        return UIImage(named: fileName) ?? #imageLiteral(resourceName: "placeholder")
        
    }
    
    
}

