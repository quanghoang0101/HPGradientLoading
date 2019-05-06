# HPGradientLoading

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/HPGradientLoading.svg?style=flat)](https://cocoapods.org/pods/HPGradientLoading)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Issues](https://img.shields.io/github/issues/quanghoang0101/HPGradientLoading.svg?style=flat
)](https://github.com/quanghoang0101/HPGradientLoading/issues?state=open)
![Build](https://travis-ci.com/quanghoang0101/HPGradientLoading.svg?branch=master)
[![codecov](https://codecov.io/gh/quanghoang0101/HPGradientLoading/branch/master/graph/badge.svg)](https://codecov.io/gh/quanghoang0101/HPGradientLoading)

HPGradientLoading is awesome library for loading activity in iOS application

![sample](https://media.giphy.com/media/IcjSzBdSDSrlyOhv0j/giphy.gif)

# Installation
#### CocoaPods
```
pod 'HPGradientLoading'
```
#### Manually
Copy the `HPGradientLoading` folder to your project.

## Conguration
* Enable blur background
```Swift
var isBlurBackground: Bool
```
* Enable blur loading activity
```Swift
var isBlurLoadingActivity: Bool
```
* Enable dismiss loading when tap
```Swift
var isEnableDismissWhenTap: Bool
```
* Size of loading activity
```Swift
var sizeOfLoadingActivity: CGFloat
```
* Gradient from color
```Swift
var fromColor: UIColor
```
* Gradient to color
```Swift
var toColor: UIColor
```
* Duration animation
```Swift
var durationAnimation: TimeInterval
```
* Blur color tinr loading activity
```Swift
var blurColorTintActivity: UIColor
```
* Blur color tint alpha for loading activity
```Swift
var blurColorTintAlphaActivity: CGFloat
```
* Blur radius loading activity
```Swift
var blurRadiusActivity: CGFloat
```
* Corner radius for loading activity
```Swift
var cornerRadiusActivity: CGFloat
```
* Gradient line width for loading activity
```Swift 
var gradientLineWidth: CGFloat
```
* Blur color tint for background
```Swift
var blurColorTintBackground: UIColor
```
* Blur color tint alpha for background
```Swift
var blurColorTintAlphaBackground: CGFloat
```
* Blur radius background
```Swift
var blurRadiusBackground: CGFloat
```
* Color for title loading
```Swift
var colorTitleLoading: UIColor
```
* Font for title loading
```Swift
var fontTitleLoading: UIFont
```
* Color for processing loading
```Swift
var colorTitleProcessing: UIColor
```
* Font for title processing
```Swift
var fontTitleProcessing: UIFont
```
## Actions
* Show loading
```Swift
func showLoading(with title: String? = nil)
```
* Show processing
```Swift
func showProcessing(with loadingTitle: String? = nil, percent: CGFloat, duration: TimeInterval = 0.1)
```
* Update processing
```Swift
func updateProcessing(with percent: CGFloat, duration: TimeInterval = 0.1)
```
* Dismiss loading
```Swift
func dismiss()
```
## Usage

### Setup
Add `import HPGradientLoading` in your file

```Swift
import UIKit
import HPGradientLoading

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = true
        HPGradientLoading.shared.configation.isBlurBackground = true
        HPGradientLoading.shared.configation.durationAnimation = 1.0
        HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: 20)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HPGradientLoading.shared.dismiss()
    }


    // MARK: - Actions
    @IBAction private func showLoadingWithTitle(_ sender: Any) {
        HPGradientLoading.shared.showLoading(with: "Loading...")
    }

    @IBAction private func showLoadingWithEmptyTitle(_ sender: Any) {
        HPGradientLoading.shared.showLoading()
    }

    @IBAction private func showProcessing(_ sender: Any) {
        self.percent = 0
        HPGradientLoading.shared.showProcessing(with: "Loading...", percent: self.percent, duration: 0.15)
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.percent += 4
            self.percent = self.percent > 100 ? 100 : self.percent
            HPGradientLoading.shared.updateProcessing(with: self.percent)
            if self.percent == 100 {timer.invalidate()}
        })
    }
}
```
## Requirements
Swift 5.0

iOS 10.0+

Xcode 10.2+

## Contributing
Forks, patches and other feedback are welcome.

## Creator
### HPGradientLoading
[Quang Hoang](https://github.com/quanghoang0101) 

[Blog](https://medium.com/@phanquanghoang)

## License
HPGradientLoading is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
