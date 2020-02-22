
import Foundation
import RxSwift
import RxCocoa

final class FilmViewModel: ViewModelType {
    
    private let peopleApi: PeopleApi
    private let film: Film
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let title: Driver<String>
        let people: Driver<[ItemViewModel]>
        let fetching: Driver<Bool>
    }
    
    init(peopleApi: PeopleApi, film: Film) {
        self.peopleApi = peopleApi
        self.film = film
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()

        let data = input.trigger.flatMapLatest {
            return Observable.combineLatest(self.film.characters.map { self.peopleApi.people($0) })
                .trackActivity(activityIndicator)
                .map { $0.map { PeopleItemViewModel(with: $0) as ItemViewModel } }
                .flatMapLatest { people -> Observable<[ItemViewModel]> in
                    var items = [ItemViewModel]()
                    items.append(FilmItemViewModel(with: self.film))
                    items.append(contentsOf: people)
                    return Observable.just(items)
                }.asDriverOnErrorJustComplete()
        }
        
        let title = Observable.just(film.title.uppercased())
            .asDriverOnErrorJustComplete()
        
        let fetching = activityIndicator.asDriver()
        
        return Output(title: title, people: data, fetching: fetching)
        
    }
    
}
