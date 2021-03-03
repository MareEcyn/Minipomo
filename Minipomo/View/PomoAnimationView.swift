//
//  Extensions.swift
//  Minipomo
//
//  Created by Loki on 19.01.2021.
//

// FIXME: Приостановленная анимация начинается с неправильного места (забегает вперед)

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
//        guard let name = anim.value(forKey: "name") as? String else { return }
//        if name == "progress", let layer = anim.value(forKey: "layer") as? CAShapeLayer {
//            layer.strokeColor = UIColor.app.green.cgColor
//        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        progressLayer.strokeColor = UIColor.Custom.darkGray.cgColor
//        guard let name = anim.value(forKey: "name") as? String else { return }
//        if name == "progress", let layer = anim.value(forKey: "layer") as? CAShapeLayer {
//            layer.strokeColor = UIColor.app.darkGray.cgColor
//        }
    }
    
    func startProgressAnimation(duration: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1.0
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
//        animation.setValue("progress", forKey: "name")
//        animation.setValue(progressLayer, forKey: "layer")
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
//        progressLayer.beginTime = 0.0
        let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = timeSincePause
    }
}
