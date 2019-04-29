//
//  ViewController.swift
//  HPGradientLoadingExample
//
//  Created by Hoang on 4/25/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit
import VisualEffectView

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = true
        HPGradientLoading.shared.configation.isBlurBackground = true

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HPGradientLoading.shared.dismiss()
    }


    // MARK: - Actions
    @IBAction private func showLoadingWithTitle(_ sender: Any) {
        HPGradientLoading.shared.show(with: "Loading...")
    }

    @IBAction private func showLoadingWithEmptyTitle(_ sender: Any) {
        HPGradientLoading.shared.show()
    }
}

