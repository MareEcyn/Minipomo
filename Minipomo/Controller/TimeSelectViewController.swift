//
//  TimeSelectViewController.swift
//  Minipomo
//
//  Created by Loki on 06.03.2021.
//

import Foundation
import UIKit

class TimeSelectViewController: UIViewController {
    @IBOutlet weak var timePicker: UIPickerView!
    private var pickerController: TimePickerController!
    var timeRange: [Int] = []
    var currentTime: Int!
    
    override func viewDidLoad() {
        pickerController = TimePickerController()
        pickerController.components = timeRange
        timePicker.delegate = pickerController
        timePicker.dataSource = pickerController
        timePicker.selectRow(timeRange.firstIndex(of: currentTime) ?? 0, inComponent: 0, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard pickerController.selectedTime != 0 else { return }
        let newTime = pickerController.selectedTime
        if title == Const.Title.focus.rawValue {
            UserDefaults.standard.setValue(newTime, forKey: Const.SettingsKey.focusTime.rawValue)
        } else if title == Const.Title.smallRest.rawValue {
            UserDefaults.standard.setValue(newTime, forKey: Const.SettingsKey.smallRestTime.rawValue)
        } else if title == Const.Title.bigRest.rawValue {
            UserDefaults.standard.setValue(newTime, forKey: Const.SettingsKey.bigRestTime.rawValue)
        }
    }
}
