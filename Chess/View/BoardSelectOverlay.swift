//
//  BoardSelectOverlay.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 19/01/2018.
//  Copyright © 2018 Pavol Margitfalvi. All rights reserved.
//

import UIKit

class BoardSelectOverlay: UIView {
    
    var overlayRects: [CGRect]?
    var colorFill = UIColor.green
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let rectsToDraw = overlayRects {
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(colorFill.cgColor)
            
            for rect in rectsToDraw {
                UIRectFill(rect)
                
            }
            
        }
        
    }
    
}
