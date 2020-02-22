
import Foundation

struct FilmItemViewModel: ItemViewModel {
    let title: String
    let producer: String
    let director: String
    let releaseYear: String
    let film: Film
    
    init(with film: Film) {
        self.title = film.title
        self.director = "Directed By: \(film.director)"
        self.producer = "Produced By: \(film.producer)"
        self.releaseYear = "Released In: \(film.releaseDate.year)"
        self.film = film
    }
    
    static func == (lhs: FilmItemViewModel, rhs: FilmItemViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.producer == rhs.producer &&
            lhs.director == rhs.director &&
            lhs.releaseYear == rhs.releaseYear
    }
}
