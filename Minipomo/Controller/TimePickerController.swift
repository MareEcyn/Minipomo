//
//  TimePickerController.swift
//  Minipomo
//
//  Created by Loki on 25.01.2021.
//

import UIKit

protocol PomoTimePickerController {
    var selectedTime: Int { get }
}

class TimePickerController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private(set) var selectedTime = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row+1)
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 72
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
           label = v as! UILabel
        }
        label.font = UIFont.systemFont(ofSize: 60)
        label.text =  String(row+1)
        label.textAlignment = .center
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = row+1
    }
}
