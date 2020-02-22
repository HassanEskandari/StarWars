
import UIKit

final class FilmsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    func bind(_ viewModel: FilmsItemViewModel) {
        
        titleLabel.text = viewModel.title
        titleLabel.font = Fonts.starJediSpecialEdition.size(28.0)
        
        releaseDateLabel.text = viewModel.releaseDate
    }
}
