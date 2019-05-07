//
//  GradientArcView.swift
//  HPGradientLoading
//
//  Created by Hoang on 4/25/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import CoreGraphics

// Rewrite from https://github.com/sfcd/SFProgressCircle/blob/master/Source/SFCircleGradientLayer.m
class GradientArcLayer: CALayer {

    var lineWidth: CGFloat = 3 {
        didSet { setNeedsDisplay() }
    }

    var numSegments: Int = 2 {
        didSet {
            _numSegments = max(2, numSegments)
            setNeedsDisplay()
        }
    }
    var progress: CGFloat = 0 {
        didSet {
            _progress = max(0, min(1, progress))
            setNeedsDisplay()
        }
    }

    // Animated
    @NSManaged var startColor: UIColor!
    @NSManaged var endColor: UIColor!
    @NSManaged private var _progress: CGFloat

    private var _numSegments: Int = 2
    private var startAngle: CGFloat = -.pi/2
    private var endAngle: CGFloat = 2 * .pi - .pi/2

    override init() {
        super.init()
        configure()
    }

    override init(layer: Any) {
        super.init(layer: layer)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)

        if self.startColor != nil, self.endColor != nil {
            self.drawWithSegments(_numSegments - 1, progress: _progress, in: ctx)
            self.drawWithSegments(_numSegments, progress: _progress, in: ctx)
        }
    }

    override class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case "startColor": return true
        case "endColor": return true
        case "startAngle": return true
        case "endAngle": return true
        case "_progress": return true
        default: return super.needsDisplay(forKey: key)
        }
    }

    private func drawWithSegments(_ segments: Int, progress: CGFloat, in context: CGContext) {
        let radius = (min(bounds.width, bounds.height)) / 2
        let durationAngle: CGFloat = (self.endAngle - self.startAngle) * progress
        if radius * durationAngle < 0.001 {return}

        let endAngle = self.startAngle + durationAngle
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let c1 = self.startColor.rgba
        let c2 = self.endColor.rgba
        var fromColor: UIColor = self.startColor

        for i in 0..<segments {
            let f_cur: CGFloat = CGFloat(i)/CGFloat(segments)
            let f: CGFloat = CGFloat(i + 1)/CGFloat(segments)
            let toColor: UIColor = UIColor(red: f * c2.red + (1 - f) * c1.red,
                                           green: f * c2.green + (1 - f) * c1.green,
                                           blue: f * c2.blue + (1 - f) * c1.blue,
                                           alpha: f * c2.alpha + (1 - f) * c1.alpha)
            let fromAngleCur: CGFloat = self.startAngle + f_cur * (endAngle - self.startAngle)
            let toAngleCur: CGFloat = self.startAngle + f * (endAngle - self.startAngle)
            self.drawSegmentAtCenter(center, from: fromAngleCur, to: toAngleCur, radius: radius, width: self.lineWidth, startColor: fromColor, endColor: toColor, context: context)
            fromColor = toColor
        }
    }

    private func drawSegmentAtCenter(_ center: CGPoint, from startAngle: CGFloat, to endAngle: CGFloat, radius: CGFloat, width: CGFloat, startColor: UIColor, endColor: UIColor, context: CGContext) {
        context.saveGState()
        context.setLineWidth(width)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        let path: UIBezierPath = UIBezierPath(arcCenter: center, radius: radius - width * 0.5, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        context.addPath(path.cgPath)
        context.replacePathWithStrokedPath()
        context.clip()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0, 1]
        let colors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        guard let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else {return}
        let startPoint: CGPoint = CGPoint(x: center.x - CGFloat(sinf(Float(startAngle - .pi/2))) * radius, y: center.y + CGFloat(cosf(Float(startAngle - .pi/2))) * radius )
        let endPoint: CGPoint = CGPoint(x: center.x - CGFloat(sinf(Float(endAngle - .pi/2))) * radius, y: center.y + CGFloat(cosf(Float(endAngle - .pi/2))) * radius)

        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        context.restoreGState()
    }

    func configure() {
        self.isOpaque = false
        self.progress = 0
        self.numSegments = 16
        self.startAngle = -.pi/2
        self.endAngle = 2 * .pi - .pi/2
    }
}
