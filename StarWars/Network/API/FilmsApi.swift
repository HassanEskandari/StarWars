
import Foundation
import RxSwift

protocol FilmsApiProvider {
    func films() -> Observable<[Film]>
}

final class FilmsApi: FilmsApiProvider {
    private let network: Network<FilmResult>
    
    init(network: Network<FilmResult>) {
        self.network = network
    }
    
    func films() -> Observable<[Film]> {
        return self.network.getItem("films").map { $0.results }
    }
}
