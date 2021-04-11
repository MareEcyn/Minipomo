//
//  SettingsController.swift
//  Minipomo
//
//  Created by Loki on 06.03.2021.
//

import Foundation
import UIKit

class SettingsController: UITableViewController {
    
    private var selectedCellIndex: IndexPath?
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var focusTime: UILabel!
    @IBOutlet weak var smallRestTime: UILabel!
    @IBOutlet weak var bigRestTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        soundSwitch.isOn = UserDefaults.standard.bool(forKey: Const.SettingsKey.soundAtCompletion.rawValue)
        notificationSwitch.isOn = UserDefaults.standard.bool(forKey: Const.SettingsKey.notifyAtCompletion.rawValue)
        focusTime.text = UserDefaults.standard.string(forKey: Const.SettingsKey.focusTime.rawValue)
        smallRestTime.text = UserDefaults.standard.string(forKey: Const.SettingsKey.smallRestTime.rawValue)
        bigRestTime.text = UserDefaults.standard.string(forKey: Const.SettingsKey.bigRestTime.rawValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let index = selectedCellIndex else { return }
        tableView.deselectRow(at: index, animated: true)
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let timeSelectViewController = segue.destination as? TimeSelectViewController,
              let id = segue.identifier
        else { return }
        if id == Const.Segue.toFocusSettings.rawValue {
            let range = UserDefaults.standard.array(forKey: Const.SettingsKey.focusTimeRange.rawValue)
            timeSelectViewController.timeRange = range as! [Int]
            timeSelectViewController.title = Const.Title.focus.rawValue
            timeSelectViewController.currentTime = UserDefaults.standard.integer(forKey: Const.SettingsKey.focusTime.rawValue)
        } else if id == Const.Segue.toSmallRestSettings.rawValue {
            let range = UserDefaults.standard.array(forKey: Const.SettingsKey.smallRestTimeRange.rawValue)
            timeSelectViewController.timeRange = range as! [Int]
            timeSelectViewController.title = Const.Title.smallRest.rawValue
            timeSelectViewController.currentTime = UserDefaults.standard.integer(forKey: Const.SettingsKey.smallRestTime.rawValue)
        } else if id == Const.Segue.toBigRestSettings.rawValue {
            let range = UserDefaults.standard.array(forKey: Const.SettingsKey.bigRestTimeRange.rawValue)
            timeSelectViewController.timeRange = range as! [Int]
            timeSelectViewController.title = Const.Title.bigRest.rawValue
            timeSelectViewController.currentTime = UserDefaults.standard.integer(forKey: Const.SettingsKey.bigRestTime.rawValue)
        }
    }
    
    @IBAction func soundSettingChanged(_ sender: UISwitch) {
        UserDefaults.standard.setValue(soundSwitch.isOn, forKey: Const.SettingsKey.soundAtCompletion.rawValue)
    }
    
    @IBAction func notificationSettingChanged(_ sender: UISwitch) {
        UserDefaults.standard.setValue(notificationSwitch.isOn, forKey: Const.SettingsKey.notifyAtCompletion.rawValue)
    }
    
}
