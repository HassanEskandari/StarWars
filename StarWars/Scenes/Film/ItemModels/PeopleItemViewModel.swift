
import Foundation

final class PeopleItemViewModel: ItemViewModel {
    let title: String
    let people: People
    
    init(with people: People) {
        self.title = people.name
        self.people = people
    }
}
