
import UIKit
import RxSwift
import RxCocoa

class FilmsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: FilmsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        bindViewModel()
    }
    
    private func configureView() {
        title = "StarWars"
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
        
        let input = FilmsViewModel.Input(trigger: Driver.merge(viewWillAppear, pulltoRefresh),
                                         selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.films.drive(tableView.rx.items(cellIdentifier: FilmsTableViewCell.reuseID, cellType: FilmsTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: disposeBag)
        
        output.selectedFilm
            .drive()
            .disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
                
    }
    
}

