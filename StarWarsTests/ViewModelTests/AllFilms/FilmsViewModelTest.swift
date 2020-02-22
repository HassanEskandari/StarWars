
import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import StarWars

class FilmsViewModelTest: XCTestCase {
    var viewModel: FilmsViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        viewModel = FilmsViewModel(filmsApi: TestFilmsApiProvider(), navigator: TestFilmsNavigator())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testFetchingFilms() {
        let films = scheduler.createObserver([FilmsItemViewModel].self)
        
        let trigger = scheduler.createColdObservable([.next(10, ())])
        let selection = scheduler.createColdObservable([Recorded<Event<IndexPath>>]())
        
        let input = FilmsViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete(),
                                         selection: selection.asDriverOnErrorJustComplete())
                
        let output = viewModel.transform(input: input)
        
        output.films.drive(films).disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(films.events.first?.value.element,
                       TestFilmsApiProvider.films.map { FilmsItemViewModel(with: $0) })
    }
    
    func testSelectingAFilm() {
        let films = scheduler.createObserver([FilmsItemViewModel].self)
        let selectedFilm = scheduler.createObserver(Film.self)
        
        let trigger = scheduler.createColdObservable([.next(1, ())])
        let selection = scheduler.createColdObservable([.next(10, IndexPath(row: 0, section: 0))])
        
        let input = FilmsViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete(),
                                         selection: selection.asDriverOnErrorJustComplete())
                
        let output = viewModel.transform(input: input)
        
        output.films.drive(films).disposed(by: disposeBag)
        output.selectedFilm.drive(selectedFilm).disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(films.events.first?.value.element,
                       TestFilmsApiProvider.films.map { FilmsItemViewModel(with: $0) })
        XCTAssertEqual(selectedFilm.events.first?.value.element,
                       TestFilmsApiProvider.films.first)
    }
    
}


