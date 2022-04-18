import UIKit

class WeatherLookupCustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    func configureData(title: String, detail: String) {
        titleLabel.text = title
        temperatureLabel.text = detail
    }
}
