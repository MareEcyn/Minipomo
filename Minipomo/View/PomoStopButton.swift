//
//  PomoStopButton.swift
//  Minipomo
//
//  Created by Loki on 22.01.2021.
//

import UIKit

class PomoStopButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        isHidden = true
    }
}
