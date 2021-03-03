//
//  PomoTimer.swift
//  Minipomo
//
//  Created by Loki on 20.01.2021.
//

// TODO: - Timer needs to be 'ms' precise, otherwise every time it paused and resumed he may result in invalid seconds remaining

import Foundation

protocol Stopwatch {
    
    /// Start new timer
    /// - Parameter duration: in seconds
    func start(duration: Int)
    func pause()
    func resume()
    
    /// Update timer with new total time
    /// - Parameter duration: in seconds
    func addTime(duration: Int)
    func stop()
}

protocol StopwatchObserver: class {
    var time: Int { get set }
}

class CountdownTimer: Stopwatch {
    
    private unowned let observer: StopwatchObserver!
    private var timer: Timer?
    private var time: Int = 0 {
        willSet { observer.time = newValue }
    }
    
    init(observer: StopwatchObserver) {
        self.observer = observer
    }
    
    func start(duration: Int) {
        guard duration > 0 else { preconditionFailure("\(#function) get invalid argument (<= 0).") }
        timer?.invalidate()
        time = duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func resume() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    func addTime(duration: Int) {
        assertionFailure("\(#function) is not implemented.")
    }
    
    func stop() {
        time = 0
        timer?.fire() // TODO: Исправить костыль.
    }
    
    @objc private func countdown() {
        guard time > 0 else {
            timer?.invalidate()
            time = 0
            return
        }
        time -= 1
    }
    
}
