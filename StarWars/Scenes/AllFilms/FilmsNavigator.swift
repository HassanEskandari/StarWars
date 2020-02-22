
import Foundation
import UIKit

protocol FilmsNavigator {
    func toFilms()
    func toFilm(_ film: Film)
}

class DefaultFilmsNavigator: FilmsNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: NetworkProvider

    init(services: NetworkProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
        
        configNavigationController()
    }
    
    private func configNavigationController() {
        self.navigationController.navigationBar.titleTextAttributes = [
            .font: Fonts.starJediSpecialEdition.size(14.0)
        ]
    }

    func toFilms() {
        let viewController: FilmsViewController = storyBoard.instantiateViewController()
        viewController.viewModel = FilmsViewModel(filmsApi: services.makeFilmsApi(), navigator: self)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toFilm(_ film: Film) {
        let viewController: FilmViewController = storyBoard.instantiateViewController()
        viewController.viewModel = FilmViewModel(peopleApi: services.makePeopleApi(), film: film)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
