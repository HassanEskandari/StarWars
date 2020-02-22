# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
inhibit_all_warnings!

def rx_datasource
  pod 'RxDataSources', '~> 4.0'
end

def rx_cocoa
  pod 'RxCocoa', '~> 5.0'
end

def rx_test
  pod 'RxTest'
  pod 'RxBlocking'
end

def alamofire
  pod 'Alamofire'
  pod 'RxAlamofire'
end

target 'StarWars' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for StarWars
  rx_cocoa
  rx_datasource
  alamofire

  target 'StarWarsTests' do
    inherit! :search_paths
    # Pods for testing
    rx_test
  end

end
