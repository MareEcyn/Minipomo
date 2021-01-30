//
//  TimeLabel.swift
//  Minipomo
//
//  Created by Loki on 22.01.2021.
//

import UIKit

class PomoTimeLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCompletedText() {
        font = font.withSize(26)
        text = "Завершено"
    }
    
    func setTimeText() {
        font = font.withSize(60)
    }
}
