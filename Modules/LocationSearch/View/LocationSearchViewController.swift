import UIKit

class LocationSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LocationSearchViewModel!
    
    struct Constants {
        static let cellIDentifier = "LocationNameCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewModelObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func prepareViewModelObserver() {
        viewModel.locationListDidUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func loadLocationList(cityName: String) {
        viewModel.loadLocationList(cityName: cityName)
    }
    
    func moveToWeatherLookUpView(location: Location) {
        viewModel.goToWeatherLookUpVC(location: location)
    }
}

extension LocationSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: #selector(self.loadLocationList(cityName:)),
                                                   object: searchText)
            perform(#selector(self.loadLocationList(cityName:)), with: searchText, afterDelay: 0.5)
        } else {
            DispatchQueue.main.async {
                self.viewModel.locationList = nil
            }
        }
    }
}


extension LocationSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if let locationList = viewModel.locationList {
            rowCount = locationList.count
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let customCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIDentifier, for: indexPath) as? LocationNameCell, let locationList = viewModel.locationList {
            let location = locationList[indexPath.row]
            customCell.configureData(location: location)
            customCell.selectionStyle = .none
            cell = customCell
        }
        return cell
    }
}

extension LocationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let locationList = viewModel.locationList {
            let location = locationList[indexPath.row]
            navigationItem.backButtonTitle = location.name
            self.moveToWeatherLookUpView(location: location)
        }
    }
}
