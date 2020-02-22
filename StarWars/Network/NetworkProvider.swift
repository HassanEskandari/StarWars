
import Foundation

final class NetworkProvider {
    private let apiEndpoint: String

    public init() {
        apiEndpoint = "https://swapi.co/api"
    }

    public func makeFilmsApi() -> FilmsApiProvider {
        let network = Network<FilmResult>(apiEndpoint)
        return FilmsApi(network: network)
    }

    public func makePeopleApi() -> PeopleApi {
        let network = Network<People>(apiEndpoint)
        return PeopleApi(network: network)
    }
}
