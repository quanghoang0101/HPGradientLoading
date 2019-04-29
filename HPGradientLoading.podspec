#
#  Be sure to run `pod spec lint HPGradientLoading.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "HPGradientLoading"
  spec.version      = "1.0.0"
  spec.summary      = "HPGradientLoading is awesome library for loading activity in iOS application"
  spec.description  = "The library for loading activity with cool animation, blur and gradient, easy integrate and custom for iOS application."
  spec.homepage     = "https://github.com/quanghoang0101/HPGradientLoading"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Hoang" => "quanghoang0101@yahoo.com.vn" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/quanghoang0101/HPGradientLoading.git", :tag => "#{spec.version}" }
  spec.source_files  = "HPGradientLoading/**/*.{swift}"
  spec.dependency "SnapKit", "~> 5.0.0"
  spec.dependency "VisualEffectView", "~> 4.0.0"
  spec.swift_version = "5"
end
