//
//  PomoStartButton.swift
//  Minipomo
//
//  Created by Loki on 21.01.2021.
//

import UIKit

class PomoStartButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    func setAsUnactive() {
        backgroundColor = UIColor.Custom.green
        setTitle(Const.Control.startButton.rawValue, for: .normal)
        setTitleColor(.white, for: .normal)
    }
    
    func setAsActive() {
        backgroundColor = UIColor.Custom.lightGray
        setTitle(Const.Control.pauseButton.rawValue, for: .normal)
        setTitleColor(.black, for: .normal)
    }
    
    func setAsPaused() {
        backgroundColor = UIColor.Custom.lightGray
        setTitle(Const.Control.resumeButton.rawValue, for: .normal)
        setTitleColor(.black, for: .normal)
    }
}
