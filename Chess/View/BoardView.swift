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
    
    
    var boardSize: CGFloat { get { return canvasSize - edgeOffset - borderSize} }
    var canvasSize: CGFloat { get { return min(bounds.width, bounds.height) } }
    
    var outlineSquareSize: CGFloat { get { return boardSize / 8 } }
    var inlineSquareSize: CGFloat { get { return (boardSize - borderSize) / 8} }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // Draws the frame around the board
        let path = UIBezierPath()
        path.lineWidth = borderSize
        
        path.move(to: CGPoint(x: rect.minX + edgeOffset / 2 + borderSize / 2,
                              y: rect.minY + edgeOffset / 2 + borderSize / 2))
        
        path.addLine(to: CGPoint(x: rect.minX + 8 * outlineSquareSize + borderSize / 2 + edgeOffset / 2,
                                 y: rect.minY + edgeOffset / 2 + borderSize / 2))
        
        path.addLine(to: CGPoint(x: rect.minX + 8 * outlineSquareSize + borderSize / 2 + edgeOffset / 2,
                                 y: rect.minY + 8 * outlineSquareSize + borderSize / 2 + edgeOffset / 2))
        
        path.addLine(to: CGPoint(x: rect.minX + edgeOffset / 2 + borderSize / 2,
                                 y: rect.minY + 8 * outlineSquareSize + borderSize / 2 + edgeOffset / 2))
        
        path.close()
        path.stroke()
        
        // Draws the squares themselves
        for y in 0..<8 {
            
            for x in 0..<8 {
                
                let xPoint = CGFloat(x) * inlineSquareSize + edgeOffset / 2 + borderSize
                let yPoint = CGFloat(y) * inlineSquareSize + edgeOffset / 2 + borderSize
                
                let rect = CGRect(x: xPoint, y: yPoint, width: inlineSquareSize, height: inlineSquareSize)
                
                let context = UIGraphicsGetCurrentContext()
                
                if (x + y) % 2 == 0 {
                    context?.setFillColor(UIColor.gray.cgColor)
                    UIRectFill(rect)
                }
                
            }
            
            
        }
        
        
    }
    
    
}
