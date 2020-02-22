
import UIKit

final class PeopleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func bind(_ viewModel: PeopleItemViewModel) {
        titleLabel.text = viewModel.title
    }
}
