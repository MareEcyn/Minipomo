//
//  Int+Ext.swift
//  Minipomo
//
//  Created by Loki on 30.01.2021.
//

import Foundation

extension Int {
    
    /// Return self as minutes and seconds
    var toTimeString: String {
        guard self > -1 else {
            preconditionFailure("negative value is not acceptable.")
        }
        let value = Double(self)
        let seconds = Int(value.truncatingRemainder(dividingBy: 60))
        let minutes = Int(value/60)
        return String(format: "%.2d:%.2d", minutes, seconds)
    }
}
