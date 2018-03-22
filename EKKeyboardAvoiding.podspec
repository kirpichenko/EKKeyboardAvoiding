Pod::Spec.new do |spec|
	spec.name         = 'EKKeyboardAvoiding'
	spec.version      = '3.1'
	spec.homepage     = 'https://github.com/K-Be/EKKeyboardAvoiding'
	spec.authors      = { 'Evgeniy Kirpichenko' => 'evkirpichenko@gmail.com'}
	spec.summary      = 'It\'s an universal solution for keyboard avoiding that automatically changes content inset of your UIScrollView instances.'
	spec.license 	  = {:type => "MIT", :file => 'LICENSE'} 
	spec.platform = :ios
	spec.ios.deployment_target = '8.0'
	spec.source       = { :git => 'https://github.com/K-Be/EKKeyboardAvoiding.git', :tag => '3.1' }
	spec.source_files = 'EKKeyboardAvoiding/*.{h,m}','EKKeyboardAvoiding/InsetsController/*.{h,m}'
	spec.frameworks    = 'UIKit', 'Foundation'
	spec.module_name = 'EKKeyboardAvoiding'
	spec.public_header_files = 'EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h', 'EKKeyboardAvoiding/EKKeyboardFrameListener.h'
  end
