import UIKit

class WeatherLookupViewController: UIViewController {
    
    var location: Location!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WeatherLookupViewModel!
    
    struct Constants {
        static let cellIDentifier = "WeatherLookupCustomCell"
    }
    
    override func viewDidLoad() {
        prepareViewModelObserver()
        if let location = location {
            viewModel.loadWeather(location: location)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func prepareViewModelObserver() {
        viewModel.weatherDataDidUpdate = { weatherResponse in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension WeatherLookupViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows = 0
        if let weatherResponse = viewModel.weatherData {
            numOfRows = weatherResponse.hourly.count
        }
        return numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let customCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIDentifier, for: indexPath) as? WeatherLookupCustomCell {
            let hourly = viewModel.weatherData.hourly[indexPath.row]
            let title = hourly.weather.first?.main ?? ""
            let detail = String(format: " Temp: %.0f °C", hourly.temp)
            customCell.configureData(title: title, detail: detail)
            customCell.selectionStyle = .none
            cell = customCell
        }
        return cell
    }
}

extension WeatherLookupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hourly = viewModel.weatherData.hourly
        let hourlyData = hourly[indexPath.row]
        self.moveToInfoView(hourly: hourlyData, cityName: location?.name ?? "")
    }
    
    func moveToInfoView(hourly: Hourly, cityName: String) {
        navigationItem.backButtonTitle = cityName
        viewModel.goToWeatherInfoVC(hourly: hourly)
    }
}
