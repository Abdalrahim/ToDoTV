# Uncomment the next line to define a global platform for your project
# platform :ios, '10.2'

target 'ToDoTV' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ToDoTV
  pod 'SwiftyJSON’
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'AlamofireNetworkActivityIndicator'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |configuration|
              configuration.build_settings['SWIFT_VERSION'] = "3.1"
          end
      end
  end

end
