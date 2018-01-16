//
//  PieceViewController.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 16/01/2018.
//  Copyright © 2018 Pavol Margitfalvi. All rights reserved.
//

import Foundation

protocol PieceViewDelegate {
    
    func pieceTouched(sender piece: PieceView?)
    
}
