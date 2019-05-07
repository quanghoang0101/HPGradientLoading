//
//  LoadingVIew.swift
//  HPGradientLoading
//
//  Created by Hoang on 5/6/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit
import VisualEffectView

class LoadingView: UIView {

    // MARK: - Observable Properties
    var sizeOfCircle: CGFloat = 70 {
        didSet {
            let size = self.sizeOfCircle
            loadingView.snp.updateConstraints { (maker) in
                maker.height.width.equalTo(size)
            }
            self.circleLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        }
    }

    // Loading Title
    var fontOfLoading: UIFont = UIFont.systemFont(ofSize: 18) {
        didSet {
            self.loadingLabel.font = fontOfLoading
        }
    }

    var textLoading: String = "" {
        didSet {
            self.loadingLabel.text = textLoading
        }
    }

    var colorTitleLoading: UIColor = .black {
        didSet {
            self.loadingLabel.textColor = colorTitleLoading
        }
    }

    var isEmptyTitleLoading: Bool = true {
        didSet {
            if isEmptyTitleLoading {
                self.loadingView.snp.updateConstraints { (maker) in
                    maker.bottom.equalTo(loadingLabel.snp.top).offset(0)
                }
            } else {
                self.loadingView.snp.updateConstraints { (maker) in
                    maker.bottom.equalTo(loadingLabel.snp.top).offset(-16)
                }
            }
        }
    }

    // Processing Title
    var fontOfProcessing: UIFont = UIFont.systemFont(ofSize: 18) {
        didSet {
            self.processingLabel.font = fontOfProcessing
        }
    }

    var textProcessing: String = "" {
        didSet {
            self.processingLabel.text = textProcessing
        }
    }

    var colorTitleProcessing: UIColor = .black {
        didSet {
            self.processingLabel.textColor = colorTitleProcessing
        }
    }

    var isHiddenProcessing: Bool = true {
        didSet {
            self.processingLabel.isHidden = isHiddenProcessing
        }
    }

    // Loadind activity
    var colorTintActivity: UIColor = .white {
        didSet {
            overlayView.colorTint = colorTintActivity
        }
    }

    var colorTintAlphaActivity: CGFloat = 0.8 {
        didSet {
            overlayView.colorTintAlpha = colorTintAlphaActivity
        }
    }

    var radiusActivity: CGFloat = 8.0 {
        didSet {
            overlayView.blurRadius = radiusActivity
        }
    }

    // MARK: - UI Properties
    private lazy var overlayView: VisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let visualEffectView = VisualEffectView(frame: .zero)
        visualEffectView.colorTint = self.colorTintActivity
        visualEffectView.colorTintAlpha = self.colorTintAlphaActivity
        visualEffectView.blurRadius = self.radiusActivity
        self.addSubview(visualEffectView)
        return visualEffectView
    }()

    private lazy var circleLayer: GradientArcLayer = {
        let layer = GradientArcLayer(layer: self.layer)
        layer.contentsScale = UIScreen.main.scale
        let size = self.sizeOfCircle
        layer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        return layer
    }()

    private lazy var loadingView: UIView = {
        let view = UIView(frame: .zero)
        self.addSubview(view)
        return view
    }()

    private lazy var loadingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Loading..."
        label.font = self.fontOfLoading
        label.numberOfLines = 0
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()

    private lazy var processingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "0%"
        label.font = self.fontOfProcessing
        label.numberOfLines = 0
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var layerClass: AnyClass {
        return GradientArcLayer.self
    }

    private var progressLayer: GradientArcLayer? {
        return layer as? GradientArcLayer
    }

    func makeConstraints() {
        overlayView.snp.makeConstraints({ (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        })

        loadingLabel.snp.makeConstraints({ (maker) in
            maker.leading.equalTo(30).priority(800)
            maker.trailing.equalTo(-30).priority(800)
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(-30)
        })
        loadingLabel.setContentHuggingPriority(UILayoutPriority(752), for: .vertical)

        loadingView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(30)
            maker.bottom.equalTo(loadingLabel.snp.top).offset(-16)
            maker.height.width.equalTo(self.sizeOfCircle)
        }

        loadingView.layer.addSublayer(self.circleLayer)

        processingLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(loadingView.snp.leading)
            maker.trailing.equalTo(loadingView.snp.trailing)
            maker.top.equalTo(loadingView.snp.top)
            maker.bottom.equalTo(loadingView.snp.bottom)
        }
    }

    func setProgress(_ progress: CGFloat, duration: TimeInterval, animation: Bool) {
        let _progress = max(0, min(1, progress))

        if !animation {
            self.circleLayer.progress = _progress
        } else {
            let currentValue: CGFloat = self.circleLayer.progress
            self.circleLayer.progress = _progress

            let anim = CABasicAnimation(keyPath: "_progress")
            anim.fromValue = currentValue
            anim.toValue = progress
            anim.duration = duration
            anim.repeatCount = 0
            anim.autoreverses = false
            anim.isRemovedOnCompletion = true
            anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            self.circleLayer.add(anim, forKey: "_progress")
        }
    }

    func rotateInfinity(duration: TimeInterval) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi*2
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = .infinity
        self.circleLayer.add(rotationAnimation, forKey: "transform.rotation")
    }

    func abortAnimation() {
        self.circleLayer.removeAnimation(forKey: "_progress")
        self.circleLayer.removeAnimation(forKey: "transform.rotation")
    }

    func resetProcessing() {
        self.circleLayer.progress = 0
    }

    func setGradientColor(formColor: UIColor, toColor: UIColor) {
        self.circleLayer.startColor = formColor
        self.circleLayer.endColor = toColor
    }
}
