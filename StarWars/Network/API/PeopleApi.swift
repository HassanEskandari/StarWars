
import Foundation
import RxSwift

final class PeopleApi {
    private let network: Network<People>
    
    init(network: Network<People>) {
        self.network = network
    }
    
    func people(_ url: String) -> Observable<People> {
        self.network.getItem(url)
    }
}
