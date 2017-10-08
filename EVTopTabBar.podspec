#
# Be sure to run `pod lib lint EVTopTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EVTopTabBar"
  s.version          = "2.2.0"
  s.homepage         = 'https://github.com/epv44/EVTopTabBar'
  s.author          = { 'Eric Vennaro' => 'epv9@case.edu' }
  s.summary          = "Custom UITabBarController with custom tabs that are at the top of the controller."
  s.description      = <<-DESC
EVTopTabBar is a custom UIPageViewController for iOS where the page control is at the top.
                       DESC

  s.license          = 'MIT'
  s.source           = { :git => "https://github.com/epv44/EVTopTabBar.git", :tag => s.version.to_s }
  s.documentation_url = 'https://epv44.github.io/docs/EVTopTabBar/index.html'
  s.platform     = :ios, '9.3'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
end
