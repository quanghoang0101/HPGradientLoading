//
//  HPGradientLoading.swift
//  HPGradientLoading
//
//  Created by Hoang on 4/26/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit
import VisualEffectView

private let maxWidthLoadingView = UIScreen.main.bounds.width - 100

public class HPGradientLoading {
    
    public static let shared = HPGradientLoading()

    public var configation = Conguration()

    private var title: String! = ""

    // MARK: - UI
    private lazy var windowView: UIWindow? = {
        return UIApplication.shared.keyWindow
    }()

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.addSubview(overlayView)
        overlayView.snp.makeConstraints({ (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        })
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var overlayView: VisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let visualEffectView = VisualEffectView(effect: effect)
        return visualEffectView
    }()

    private lazy var loadingViewContainer: LoadingView = {
        let view = LoadingView(frame: .zero)
        view.layer.cornerRadius = self.configation.cornerRadiusActivity
        view.layer.borderWidth = 0
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.clear.cgColor
        view.setGradientColor(formColor: self.configation.fromColor, toColor: self.configation.toColor)
        containerView.addSubview(view)
        view.snp.makeConstraints({ (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalTo(self.configation.sizeOfLoadingActivity + 60).priority(650)
            maker.width.equalTo(maxWidthLoadingView).priority(650)
            maker.width.equalTo(view.snp.height).priority(650)
        })

        return view
    }()

    // MARK: - Private methods
    private func makeContraints() {
        guard let windowView = windowView else { return }

        windowView.addSubview(containerView)
        containerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    internal func applyStyle() {
        // Blur background
        if self.configation.isBlurBackground {
            self.overlayView.colorTint = self.configation.blurColorTintBackground
            self.overlayView.colorTintAlpha = self.configation.blurColorTintAlphaBackground
            self.overlayView.blurRadius = self.configation.blurRadiusBackground
        } else {
            self.overlayView.colorTint = .clear
            self.overlayView.colorTintAlpha = 1
            self.overlayView.blurRadius = 0
        }

        // Blur loading activity
        if self.configation.isBlurLoadingActivity {
            self.loadingViewContainer.colorTintActivity = self.configation.blurColorTintActivity
            self.loadingViewContainer.colorTintAlphaActivity = self.configation.blurColorTintAlphaActivity
            self.loadingViewContainer.radiusActivity = self.configation.blurRadiusActivity
        } else {
            self.loadingViewContainer.colorTintActivity = .clear
            self.loadingViewContainer.colorTintAlphaActivity = 1
            self.loadingViewContainer.radiusActivity = 0
        }

        // Loading
        self.loadingViewContainer.textLoading = self.title
        self.loadingViewContainer.colorTitleLoading = self.configation.colorTitleLoading
        self.loadingViewContainer.fontOfLoading = self.configation.fontTitleLoading

        // Processing
        self.loadingViewContainer.setGradientColor(formColor: self.configation.fromColor, toColor: self.configation.toColor)
        self.loadingViewContainer.isEmptyTitleLoading = self.title.isEmpty
        self.loadingViewContainer.colorTitleProcessing = self.configation.colorTitleProcessing
        self.loadingViewContainer.fontOfProcessing = self.configation.fontTitleProcessing

        let widthOfString = self.title.widthOfString(usingFont: self.configation.fontTitleLoading)
        let fullWidthString = widthOfString + 60
        if fullWidthString > UIScreen.main.bounds.width - 100 {
            loadingViewContainer.snp.remakeConstraints({ (maker) in
                maker.centerX.centerY.equalToSuperview()
                maker.width.equalTo(self.configation.sizeOfLoadingActivity + 60).priority(650)
                maker.width.equalTo(maxWidthLoadingView).priority(800)
                maker.width.equalTo(loadingViewContainer.snp.height).priority(650)
            })
        } else {
            loadingViewContainer.snp.remakeConstraints({ (maker) in
                maker.centerX.centerY.equalToSuperview()
                maker.width.equalTo(self.configation.sizeOfLoadingActivity + 60).priority(650)
                maker.width.equalTo(maxWidthLoadingView).priority(650)
                maker.width.equalTo(loadingViewContainer.snp.height).priority(650)
            })
        }

    }

    // MARK: - Actions
    public func showLoading(with title: String? = nil) {
        self.makeContraints()
        self.title = title ?? ""
        self.applyStyle()

        self.loadingViewContainer.isHiddenProcessing = true

        self.setProgress(80, duration: 0.0, animation: false)
        self.loadingViewContainer.rotateInfinity(duration: self.configation.durationAnimation)
    }

    public func dismiss() {
        self.containerView.removeFromSuperview()
        self.loadingViewContainer.resetProcessing()
        self.loadingViewContainer.abortAnimation()
    }

    @objc private func dismiss(_ sender: Any) {
        if self.configation.isEnableDismissWhenTap {
            self.dismiss()
        }
    }

    // MARK: Processing
    public func showProcessing(with loadingTitle: String? = nil, percent: CGFloat, duration: TimeInterval = 0.1) {
        self.makeContraints()
        self.title = loadingTitle ?? ""

        self.applyStyle()

        // Processing
        let percentString = String(format: "%.0f%%", percent)
        self.loadingViewContainer.textProcessing = percentString

        self.loadingViewContainer.isHiddenProcessing = false
        self.loadingViewContainer.isEmptyTitleLoading = self.title.isEmpty
        self.loadingViewContainer.isHiddenProcessing = false

        self.setProgress(percent, duration: duration, animation: true)
    }

    public func updateProcessing(with percent: CGFloat, duration: TimeInterval = 0.1) {
        let percentString = String(format: "%.0f%%", percent)
        self.loadingViewContainer.textProcessing = percentString
        self.setProgress(percent, duration: duration, animation: true)
    }

    func setProgress(_ percent: CGFloat, duration: TimeInterval, animation: Bool) {
        self.loadingViewContainer.setProgress(percent/100, duration: duration, animation: animation)
    }
}
