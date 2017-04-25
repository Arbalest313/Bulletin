use_frameworks!
platform :ios, '9.0'

def ui
	pod 'SnapKit'
	pod 'SDWebImage/WebP'
	pod 'SDWebImage/GIF'
    pod 'RxCocoa', '~> 3.0'
    pod 'RxDataSources', '~> 1.0'

    pod 'Material', '~> 2.0'
    pod 'MBProgressHUD', '~> 1.0.0'
    #pod "Hero"

end

def wrapper
	pod 'Moya/RxSwift'
    pod "Moya-SwiftyJSONMapper/RxSwift"
    pod 'SwiftyUserDefaults'
    pod 'Then', '~> 2.1'

end

def platform
    pod 'IQKeyboardManagerSwift'
    pod 'Reachability', '~> 3.2'
    pod 'RxSwift',  '~> 3.0'
    pod 'XCGLogger', '~> 4.0.0'
end

target  "Bulletin"  do
	ui
	wrapper
	platform
end
