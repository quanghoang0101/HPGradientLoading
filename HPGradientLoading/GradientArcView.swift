//
//  GradientArcView.swift
//  HPGradientLoadingExample
//
//  Created by Hoang on 4/25/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

class GradientArcView: UIView {

    var lineWidth: CGFloat = 3 { didSet { setNeedsLayout() } }
    var colors: [UIColor] = [.white, .blue] { didSet { setNeedsLayout() } }
    var duration: TimeInterval = 1.5 { didSet { setNeedsLayout() }}

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .conic
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateGradient()
        rotateInfinity()
    }

    func configure() {
        layer.addSublayer(gradientLayer)
    }

    func updateGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 3/2 * .pi, clockwise: true)
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = lineWidth
        mask.path = path.cgPath
        gradientLayer.mask = mask
    }

    func rotateInfinity() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi*2
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = .infinity
        gradientLayer.add(rotationAnimation, forKey: nil)
    }
}

