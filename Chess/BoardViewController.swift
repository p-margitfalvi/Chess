//
//  ViewController.swift
//  Chess
//
//  Created by Pavol Margitfalvi on 18/12/2017.
//  Copyright © 2017 Pavol Margitfalvi. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
    let board = BoardModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    private func viewToModelCoords(view: PieceView) -> (Int, Int) {
        
        return (0, 0)
    }
    
    private func modelCoordsToView(coords: (Int, Int)) -> PieceView {
        
        return PieceView()
    }*/


}

