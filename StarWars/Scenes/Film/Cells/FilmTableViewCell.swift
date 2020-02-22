
import UIKit

final class FilmTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!

    func bind(_ viewModel: FilmItemViewModel) {
        titleLabel.text = viewModel.title
        directorLabel.text = viewModel.director
        producerLabel.text = viewModel.producer
        releaseYearLabel.text = viewModel.releaseYear
    }
}
