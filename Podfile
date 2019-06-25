# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'popmovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PopMovies
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ObjectMapper'
  pod 'RxAlamofire'
  pod 'Kingfisher'
  pod 'UIImageColors'
  pod 'Hero'
  pod "YoutubePlayer-in-WKWebView"
  
  target 'popmoviesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'popmoviesUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end
end
