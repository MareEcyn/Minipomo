//
//  Extensions.swift
//  Minipomo
//
//  Created by Loki on 19.01.2021.
//

import UIKit

class PomoAnimationView: UIView {
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundLayer.path = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: 150, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true).cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.Custom.lightGray.cgColor
        backgroundLayer.lineWidth = 8.0
        progressLayer.path = backgroundLayer.path
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.Custom.green.cgColor
        progressLayer.lineWidth = 8.0
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
    }
}

extension PomoAnimationView: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        progressLayer.strokeColor = UIColor.Custom.green.cgColor
    }
    
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        progressLayer.strokeColor = UIColor.Custom.darkGray.cgColor
//    }
    
    func startProgressAnimation(duration: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1.0
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        progressLayer.add(animation, forKey: "progress")
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
    }
    
    func stopProgressAnimation() {
        progressLayer.removeAnimation(forKey: "progress")
        progressLayer.strokeColor = UIColor.Custom.green.cgColor
    }
    
    func pauseProgressAnimation() {
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }
    
    func resumeProgressAnimation() {
        let pausedTime = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0
        let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
    }
}
