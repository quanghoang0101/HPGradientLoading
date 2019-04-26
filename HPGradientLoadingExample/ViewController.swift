//
//  ViewController.swift
//  HPGradientLoadingExample
//
//  Created by Hoang on 4/25/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var gradientView: GradientArcView = {
        let view = GradientArcView(frame: .zero)
        self.view.addSubview(view)
        view.snp.makeConstraints({ (maker) in
            maker.width.height.equalTo(100)
            maker.centerX.centerY.equalToSuperview()
        })
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.gradientView.backgroundColor = .clear
    }


}

