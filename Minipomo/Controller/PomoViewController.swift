//
//  ViewController.swift
//  Minipomo
//
//  Created by Loki on 19.01.2021.
//

// TODO: При отрисовке timePicker грузить последний выбор, или 50 минут.
// TODO: При нажатии кнопки "Стоп" грузить последний выбор, или 50 минут.
// TODO: Таймер должен восстановить работу после выхода из background mode
// TODO: hideTimePicker() violate SRP
// TODO: Доделать flow of control для полного завершения помо

import UIKit

class PomoViewController: UIViewController, StopwatchObserver {
    private enum PomoStatus {
        case unactive, active, paused, resumed, completed, stopped
    }
    
    @IBOutlet weak var pomoAnimationView: PomoAnimationView!
    @IBOutlet weak var timeLabel: PomoTimeLabel!
    @IBOutlet weak var startButton: PomoStartButton!
    @IBOutlet weak var stopButton: UIButton!
    
    private var timePicker: UIPickerView!
    private var timePickerController: TimePickerController!
    private var status: PomoStatus!
    
    private var timer: Stopwatch!
    var time: Int = 0 {
        willSet(value) {
            timeLabel.text = value.toTimeString
            if value == 0 {
                switchPomoStatus(to: .completed)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        status = .unactive
        timer = CountdownTimer(observer: self)
        timePicker = UIPickerView()
        timePickerController = TimePickerController()
        timePicker.delegate = timePickerController
        timePicker.dataSource = timePickerController
        setGestures()
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        switch status {
        case .unactive:
            switchPomoStatus(to: .active)
        case .active:
            switchPomoStatus(to: .paused)
        case .completed:
            switchPomoStatus(to: .unactive)
        case .paused:
            switchPomoStatus(to: .resumed)
        case .stopped, .resumed, .none: // not applicable
            break
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        switchPomoStatus(to: .stopped)
    }
    
    private func switchPomoStatus(to status: PomoStatus) {
        switch status {
        case .unactive:
            timer.stop()
            pomoAnimationView.stopProgressAnimation()
            startButton.setAsUnactive()
            stopButton.isHidden = false
        case .active:
            timer.start(duration: time)
            pomoAnimationView.startProgressAnimation(duration: Double(time))
            startButton.setAsActive()
            hideTimePicker()
            self.status = .active
        case .paused:
            timer.pause()
            pomoAnimationView.pauseProgressAnimation()
            startButton.setAsPaused()
            stopButton.isHidden = false
            self.status = .paused
        case .resumed:
            timer.resume()
            pomoAnimationView.resumeProgressAnimation()
            startButton.setAsActive()
            stopButton.isHidden = true
            self.status = .active
        case .completed:
            startButton.setAsUnactive()
            stopButton.isHidden = true
            self.status = .unactive
        case .stopped:
            timer.stop()
            pomoAnimationView.stopProgressAnimation()
            startButton.setAsUnactive()
            stopButton.isHidden = true
            self.status = .unactive
        }
    }
    
    private func setGestures() {
        let gestureShowTimePicker = UITapGestureRecognizer(target: self, action: #selector(showTimePicker))
        let gestureHideTimePicker = UITapGestureRecognizer(target: self, action: #selector(hideTimePicker))
        timeLabel.addGestureRecognizer(gestureShowTimePicker)
        view.addGestureRecognizer(gestureHideTimePicker)
    }
    
    @objc private func showTimePicker() {
        timeLabel.isHidden = true
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        pomoAnimationView.addSubview(timePicker)
        timePicker.centerXAnchor.constraint(equalTo: pomoAnimationView.centerXAnchor).isActive = true
        timePicker.centerYAnchor.constraint(equalTo: pomoAnimationView.centerYAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalTo: pomoAnimationView.widthAnchor, constant: -128).isActive = true
        timePicker.selectRow(49, inComponent: 0, animated: true)
    }
    
    @objc private func hideTimePicker() {
        time = timePickerController.selectedTime * 60
        timePicker.removeFromSuperview()
        timeLabel.isHidden = false
    }

}