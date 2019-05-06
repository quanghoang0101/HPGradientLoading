//
//  Conguration.swift
//  HPGradientLoading
//
//  Created by Hoang on 4/29/19.
//  Copyright © 2019 Quang Hoang. All rights reserved.
//

import UIKit

public struct Conguration {
    public var isBlurBackground: Bool = true
    public var isBlurLoadingActivity: Bool = true

    public var isEnableDismissWhenTap: Bool = false

    public var sizeOfLoadingActivity: CGFloat = 70.0
    public var fromColor: UIColor = .blue
    public var toColor: UIColor = .white
    public var durationAnimation: TimeInterval = 1.0

    // Loading activity properties
    public var blurColorTintActivity: UIColor = .white
    public var blurColorTintAlphaActivity: CGFloat = 0.8
    public var blurRadiusActivity: CGFloat = 8.0

    public var cornerRadiusActivity: CGFloat = 8.0
    public var gradientLineWidth: CGFloat = 3.0

    // Background properties
    public var blurColorTintBackground: UIColor = .white
    public var blurColorTintAlphaBackground: CGFloat = 0.2
    public var blurRadiusBackground: CGFloat = 8.0

    public var colorTitleLoading: UIColor = .blue
    public var fontTitleLoading: UIFont = UIFont.systemFont(ofSize: 18)

    public var colorTitleProcessing: UIColor = .blue
    public var fontTitleProcessing: UIFont = UIFont.systemFont(ofSize: 15)

    public init() {}
}
