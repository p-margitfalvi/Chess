//
//  BoardView.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 18/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import UIKit

@IBDesignable
class BoardView: UIView {
    
    @IBInspectable
    var borderSize: CGFloat = 5
    
    //@IBInspectable
    var edgeOffset: CGFloat = 0
    
    private var pSquareSize: CGFloat = 0
    
    var squareSize: CGFloat {
        
        get {
            return pSquareSize
        }
        
    }
    

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let canvasSize = min(bounds.width, bounds.height)
        let boardSize = canvasSize - borderSize - (2 * edgeOffset)
        let path = UIBezierPath()
        path.lineWidth = borderSize
        let lineOffset = edgeOffset / 16;
        
        for lineCount in 0..<9 {
            
            // Vertical lines
            var currentPoint = CGPoint(x: (CGFloat(lineCount) * boardSize / 8) + borderSize / 2 + lineOffset, y: bounds.minY + lineOffset)
            path.move(to: currentPoint)
            if lineCount == 8 {
                path.addLine(to: CGPoint(x: currentPoint.x, y: bounds.minY + boardSize + borderSize - lineOffset))
            } else {
                path.addLine(to: CGPoint(x: currentPoint.x, y: bounds.minY + boardSize - lineOffset))
            }
            
            // Horizontal lines
            currentPoint = CGPoint(x: bounds.minX + lineOffset, y: (CGFloat(lineCount) * boardSize / 8) + borderSize / 2 + lineOffset)
            path.move(to: currentPoint)
            path.addLine(to: CGPoint(x: bounds.minX + boardSize - lineOffset, y: currentPoint.y))
            
        }
        
        
        path.stroke()
        
        
        
        
        
        
    }
 

}
