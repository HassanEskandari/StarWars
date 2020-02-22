
import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class FilmViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: FilmViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
        tableView.separatorColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 117/255.0, alpha: 1.0)
        tableView.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map{ _ in }
            .asDriver { _ in Driver.empty() }
        let pulltoRefresh = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = FilmViewModel.Input(trigger: Driver.merge(viewWillAppear, pulltoRefresh))
        let output = viewModel.transform(input: input)
        
        output.people
            .map({ items in
                let sections: [MultipleSectionModel] = [
                    .FilmSection(title: "Film Info", items: items.filter { $0 is FilmItemViewModel }),
                    .PeopleSection(title: "Characters", items: items.filter { $0 is PeopleItemViewModel })
                ]
                return sections
            })
            .drive(tableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
        
        output.title
            .drive(rx.title)
            .disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
                
    }
}
