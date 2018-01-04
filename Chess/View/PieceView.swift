//
//  PieceView.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 31/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import UIKit

class PieceView: UIView {
    
    var pieceImage: UIImage! {
        
        didSet {
            setNeedsDisplay()
        }
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
