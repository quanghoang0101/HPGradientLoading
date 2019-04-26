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
//        visualEffectView.colorTint = .white
//        visualEffectView.colorTintAlpha = 0.2
//        visualEffectView.blurRadius = 8

        return visualEffectView
    }()

    private lazy var subViewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 8
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
        visualEffectView.colorTint = .white
        visualEffectView.colorTintAlpha = 0.6
        visualEffectView.blurRadius = 10
        subViewContainer.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints({ (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
        })
        return visualEffectView
    }()

    private lazy var loadingView: GradientArcView = {
        let view = GradientArcView(frame: .zero)
        view.colors = [.red, .green, .blue]
        subViewContainer.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.greaterThanOrEqualTo(30).priority(750)
            maker.trailing.greaterThanOrEqualTo(-30).priority(750)
            maker.centerX.equalToSuperview()
            maker.top.equalTo(30)
            maker.bottom.equalTo(titleLoading.snp.top).offset(-16)
            maker.height.width.equalTo(100)
        }
        return view
    }()

    private lazy var titleLoading: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 18)
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

        self.subViewContainer.backgroundColor = .clear
        self.loadingOverlayViewContainer.backgroundColor = .clear
        self.loadingView.backgroundColor = .clear
        self.titleLoading.textColor = .darkText
    }

    // MARK: - Actions
    public func show() {
        self.makeContraints()
        self.containerView.alpha = 1
        self.titleLoading.text = nil
        self.loadingView.layoutSubviews()

        self.loadingView.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(titleLoading.snp.top).offset(0)
        }
    }

    public func show(with title: String) {
        self.makeContraints()
        self.containerView.alpha = 1
        self.titleLoading.text = title
        self.loadingView.layoutSubviews()

        self.loadingView.snp.updateConstraints { (maker) in
            maker.bottom.equalTo(titleLoading.snp.top).offset(-16)
        }
    }

    public func dismiss() {
        self.containerView.removeFromSuperview()
    }

    @objc private func dismiss(_ sender: Any) {
        self.dismiss()
    }
}
