//
//  PieceView.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 31/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import UIKit

class PieceView: UIImageView{
    
    // CHANGE THE OPTIONAL LATER
    var pieceColor: UIColor?/*
    var delegate: PieceViewDelegate? {
        
        didSet {
            
            touchRecognizer
            
        }
        
    }
    
    let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector (delegate?.pieceTouched(sender: self)))*/
    
    init(pieceColor color: UIColor, frame: CGRect) {
        pieceColor = color
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}
