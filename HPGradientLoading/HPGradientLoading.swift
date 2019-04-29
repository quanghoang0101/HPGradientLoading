//
//  HPGradientLoading.swift
//  HPGradientLoadingExample
//
//  Created by Hoang on 4/26/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit
import VisualEffectView

public class HPGradientLoading {
    
    public static let shared = HPGradientLoading()

    public var configation = Conguration()

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
            maker.width.equalTo(view.snp.height).priority(750)
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

    private lazy var subViewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = self.configation.cornerRadiusActivity
        view.layer.borderWidth = 0
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.clear.cgColor
        containerView.addSubview(view)
        view.snp.makeConstraints({ (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalTo(view.snp.height)
        })

        return view
    }()

    private lazy var loadingOverlayViewContainer: VisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let visualEffectView = VisualEffectView(frame: .zero)
        visualEffectView.colorTint = self.configation.blurColorTintActivity
        visualEffectView.colorTintAlpha = self.configation.blurColorTintAlphaActivity
        visualEffectView.blurRadius = self.configation.blurRadiusActivity
        subViewContainer.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints({ (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        })
        return visualEffectView
    }()

    private lazy var loadingView: GradientArcView = {
        let view = GradientArcView(frame: .zero)
        view.colors = self.configation.gradientColors
        subViewContainer.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.greaterThanOrEqualTo(30).priority(750)
            maker.trailing.greaterThanOrEqualTo(-30).priority(750)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(30)
            maker.bottom.equalTo(titleLoading.snp.top).offset(-16)
            maker.height.width.equalTo(self.configation.sizeOfLoadingActivity)
        }
        return view
    }()

    private lazy var titleLoading: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Loading..."
        label.font = self.configation.fontTitleLoading
        label.numberOfLines = 0
        label.textAlignment = .center
        subViewContainer.addSubview(label)
        label.snp.makeConstraints({ (maker) in
            maker.leading.equalTo(30).priority(500)
            maker.trailing.equalTo(-30).priority(500)
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(-30)
        })
        return label
    }()

    // MARK: - Private methods
    private func makeContraints() {
        guard let windowView = windowView else { return }

        windowView.addSubview(containerView)
        containerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    private func applyStyle() {
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
            self.loadingOverlayViewContainer.colorTint = self.configation.blurColorTintActivity
            self.loadingOverlayViewContainer.colorTintAlpha = self.configation.blurColorTintAlphaActivity
            self.loadingOverlayViewContainer.blurRadius = self.configation.blurRadiusActivity
        } else {
            self.loadingOverlayViewContainer.colorTint = .clear
            self.loadingOverlayViewContainer.colorTintAlpha = 1
            self.loadingOverlayViewContainer.blurRadius = 0
        }

        self.loadingView.colors = self.configation.gradientColors
        self.loadingView.lineWidth = self.configation.gradientLineWidth
        self.loadingView.duration = self.configation.durationAnimation
        self.loadingView.layoutSubviews()

        self.titleLoading.textColor = self.configation.colorTitleLoading
        self.titleLoading.font = self.configation.fontTitleLoading

    }

    // MARK: - Actions
    public func show() {
        self.makeContraints()
        self.applyStyle()

        self.titleLoading.text = nil

        self.loadingView.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(titleLoading.snp.top).offset(0)
        }
    }

    public func show(with title: String) {
        self.makeContraints()
        self.applyStyle()

        self.titleLoading.text = title

        self.loadingView.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(titleLoading.snp.top).offset(-16)
        }
    }

    public func dismiss() {
        self.containerView.removeFromSuperview()
    }

    @objc private func dismiss(_ sender: Any) {
        if self.configation.isEnableDismissWhenTap {
            self.dismiss()
        }
    }
}
