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
        backgroundColor = UIColor.app.green
        setTitle("Старт", for: .normal)
        setTitleColor(.white, for: .normal)
    }
    
    func setAsActive() {
        backgroundColor = UIColor.app.lightGray
        setTitle("Пауза", for: .normal)
        setTitleColor(.black, for: .normal)
    }
    
    func setAsPaused() {
        backgroundColor = UIColor.app.lightGray
        setTitle("Дальше", for: .normal)
        setTitleColor(.black, for: .normal)
    }
}
