Pod::Spec.new do |s|
  s.name             = "FlipFlobjc"
  s.version          = "0.1.0"
  s.summary          = "Obj-C tool for rendering UIKit views into PNG sequences for use in WatchKit animations."
  s.description      = <<-DESC
                    An Objective-C reimplementation of [Flipbook](https://github.com/frosty/Flipbook) with added features:

                       * Custom image output directories
                       * Ability to specify a callback block to be executed when image capture is complete

                       DESC
  s.homepage         = "https://github.com/stonesam92/FlipFlobjc"
  s.license          = 'MIT'
  s.author           = { "Sam Stone" => "stonesam92@gmail.com" }
  s.source           = { :git => "https://github.com/stonesam92/FlipFlobjc.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/cmdshiftn'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FlipFlobjc' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
