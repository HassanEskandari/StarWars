
import UIKit
import RxDataSources
import RxCocoa
import RxSwift

extension FilmViewController {
    func dataSource() -> RxTableViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxTableViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { dataSource, table, indexPath, _ in
                switch dataSource[indexPath] {
                case let item where item is FilmItemViewModel:
                    let cell: FilmTableViewCell = table.dequeueReusableCell(at: indexPath)
                    cell.bind(item as! FilmItemViewModel)
                    return cell
                case let item where item is PeopleItemViewModel:
                    let cell: PeopleTableViewCell = table.dequeueReusableCell(at: indexPath)
                    cell.bind(item as! PeopleItemViewModel)
                    return cell
                default:
                    fatalError()
                }
            },
            titleForHeaderInSection: { dataSource, index in
                let section = dataSource[index]
                return section.title
            }
        )
    }
}

enum MultipleSectionModel {
    case FilmSection(title: String, items: [ItemViewModel])
    case PeopleSection(title: String, items: [ItemViewModel])
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = ItemViewModel
    
    var items: [Item] {
        switch self {
        case .FilmSection(title: _, items: let items):
            return items
        case .PeopleSection(title: _, items: let items):
            return items
        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .FilmSection(title: title, items: _):
            self = .FilmSection(title: title, items: items)
        case let .PeopleSection(title, _):
            self = .PeopleSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .FilmSection(title: let title, items: _):
            return title
        case .PeopleSection(title: let title, items: _):
            return title
        }
    }
}
