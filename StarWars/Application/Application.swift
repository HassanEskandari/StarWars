
import Foundation
import UIKit


final class Application {
    static let shared = Application()
    
    public func configureMainInterface(in window: UIWindow) {
        let networkProvider = NetworkProvider()

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Application.self))
        let navigattionController = UINavigationController()
        let navigator = DefaultFilmsNavigator(services: networkProvider,
                                              navigationController: navigattionController,
                                              storyBoard: storyboard)
        
        window.rootViewController = navigattionController
        
        navigator.toFilms()
    }
}
