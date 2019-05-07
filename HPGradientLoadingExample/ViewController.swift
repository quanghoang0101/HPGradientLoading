//
//  ViewController.swift
//  HPGradientLoadingExample
//
//  Created by Hoang on 4/25/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import HPGradientLoading

class ViewController: UIViewController {

    var percent: CGFloat = 0
    var timer: Timer? = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = true
        HPGradientLoading.shared.configation.isBlurBackground = true
        HPGradientLoading.shared.configation.isBlurLoadingActivity = true
        HPGradientLoading.shared.configation.durationAnimation = 1.5
        HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: 20)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    // MARK: - Actions
    @IBAction private func showLoadingWithTitle(_ sender: Any) {
        self.timer?.invalidate()
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue

        HPGradientLoading.shared.showLoading(with: "Loading...")
    }

    @IBAction private func showLoadingWithEmptyTitle(_ sender: Any) {
        self.timer?.invalidate()
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading()
    }

    @IBAction private func showProcessing(_ sender: Any) {
        self.percent = 0
        HPGradientLoading.shared.configation.fromColor = .blue
        HPGradientLoading.shared.configation.toColor = .white
        HPGradientLoading.shared.showProcessing(with: "Loading...", percent: self.percent, duration: 0.15)
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.percent += 4
            self.percent = self.percent > 100 ? 100 : self.percent
            HPGradientLoading.shared.updateProcessing(with: self.percent)
            if self.percent == 100 {timer.invalidate()}
        })
    }
}

