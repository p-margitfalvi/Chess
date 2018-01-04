//
//  BoardView.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 18/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import UIKit

enum BoardColor: Int {
    
    case Black = 0
    case White = 1
    
}

@IBDesignable
class BoardView: UIView {
    
    @IBInspectable
    var borderSize: CGFloat = 5
    
    @IBInspectable
    var edgeOffset: CGFloat = 0
    
    
    private var boardSize: CGFloat { get { return canvasSize - edgeOffset - borderSize} }
    private var canvasSize: CGFloat { get { return min(bounds.width, bounds.height) } }
    
    var boardMatrix = [[PieceView!]](repeatElement([PieceView!](repeatElement(nil, count: 8)), count: 8))
    
    var squareSize: CGFloat { get { return boardSize / 8 } }
    
    override func layoutSubviews() {
        
        for view in subviews {
            view.removeFromSuperview()
        }
        
        for x in 0..<8 {
            
            for y in 0..<8 {
                
                let xPoint = CGFloat(x) * squareSize + edgeOffset / 2 + borderSize / 2
                let yPoint = CGFloat(y) * squareSize + edgeOffset / 2 + borderSize / 2
                let squareFrame = CGRect(x: xPoint, y: yPoint, width: squareSize, height: squareSize)
                
                let view = PieceView(squareColor: BoardColor(rawValue: (x + y) % 2)!, frame: squareFrame)
                boardMatrix[y][x] = view
                addSubview(view)
            }
            
        }
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        path.lineWidth = borderSize
        
        path.move(to: CGPoint(x: rect.minX + edgeOffset / 2 + borderSize / 2,
                              y: rect.minY + edgeOffset / 2 + borderSize / 2))
        
        path.addLine(to: CGPoint(x: rect.minX + 8 * squareSize + borderSize / 2 + edgeOffset / 2,
                                 y: rect.minY + edgeOffset / 2 + borderSize / 2))
        
        path.addLine(to: CGPoint(x: rect.minX + 8 * squareSize + borderSize / 2 + edgeOffset / 2,
                                 y: rect.minY + 8 * squareSize + borderSize / 2 + edgeOffset / 2))
        
        path.addLine(to: CGPoint(x: rect.minX + edgeOffset / 2 + borderSize / 2,
                                 y: rect.minY + 8 * squareSize + borderSize / 2 + edgeOffset / 2))
        
        path.close()
        path.stroke()
    }
    
    
}
