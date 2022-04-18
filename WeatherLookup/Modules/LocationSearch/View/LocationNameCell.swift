import UIKit

class LocationNameCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!

    func configureData(location: Location) {
        locationNameLabel.text = "\(location.name) , \(location.country)"
    }
}
