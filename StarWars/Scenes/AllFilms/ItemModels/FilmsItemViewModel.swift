
import Foundation

final class FilmsItemViewModel: ItemViewModel, Equatable {
    let title: String
    let releaseDate: String
    let film: Film
    
    init(with film: Film) {
        self.title = film.title
        self.releaseDate = "Release Date: \(film.releaseDate.toString())"
        self.film = film
    }

    static func == (lhs: FilmsItemViewModel, rhs: FilmsItemViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.releaseDate == rhs.releaseDate
    }
    
}
