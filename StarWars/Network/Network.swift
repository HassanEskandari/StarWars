
import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final class Network<T: Decodable> {

    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler

    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    private func getAbsolutePath(_ path: String) -> String {
        if path.starts(with: endPoint) {
            return path
        } else {
            return "\(endPoint)/\(path)"
        }
    }
    
    func getItems(_ path: String) -> Observable<[T]> {
        let absolutePath = getAbsolutePath(path)
        return RxAlamofire
            .data(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ data -> [T] in
                return try JSONDecoder().decode([T].self, from: data)
            })
    }

    func getItem(_ path: String) -> Observable<T> {
        let absolutePath = getAbsolutePath(path)
        return RxAlamofire
            .data(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
}
