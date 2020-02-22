
import Foundation
import RxSwift
import RxCocoa

final class FilmsViewModel: ViewModelType {
    
    private let filmsApi: FilmsApiProvider
    private let navigator: FilmsNavigator
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let films: Driver<[FilmsItemViewModel]>
        let selectedFilm: Driver<Film>
        let error: Driver<Error>
    }
    
    init(filmsApi: FilmsApiProvider, navigator: FilmsNavigator) {
        self.filmsApi = filmsApi
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let films = input.trigger.flatMapLatest {
            return self.filmsApi.films()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .map { films in
                    return films.sorted { (film1, film2) -> Bool in
                        return film1.releaseDate > film2.releaseDate
                    }
                }
                .asDriverOnErrorJustComplete()
                .map { $0.map { FilmsItemViewModel(with: $0) } }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedFilm = input.selection
            .withLatestFrom(films) { (indexPath, films) -> Film in
                return films[indexPath.row].film
        }.do(onNext: { self.navigator.toFilm($0) })
        
        return Output(fetching: fetching,
                      films: films,
                      selectedFilm: selectedFilm,
                      error: errors)
    }
}
