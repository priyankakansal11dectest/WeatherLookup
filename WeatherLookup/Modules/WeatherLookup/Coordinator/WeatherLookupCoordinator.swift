import UIKit

final class WeatherLookupCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let location: Location
    
    init(navigationController: UINavigationController, location: Location) {
        self.navigationController = navigationController
        self.location = location
    }
    
    // Api Client dependency
    private var weatherLookupNetworkService: WeatherLookupNetworkServiceProtocol {
        return WeatherLookupService()
    }
    
    func start() {
        // Instantiate WeatherLookupViewController
        if let weatherLookupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherLookupViewController") as? WeatherLookupViewController {
            weatherLookupVC.location = location
            // Instantiate WeatherLookupViewModel with Service dependecy
            let weatherLookupVM = WeatherLookupViewModel(weatherLookupNetworkServiceProtocol: weatherLookupNetworkService)
            // Set the Coordinator to the ViewModel
            weatherLookupVM.coordinator = self
            // Set the ViewModel to ViewController
            weatherLookupVC.viewModel = weatherLookupVM
            let backItem = UIBarButtonItem()
            backItem.title = location.name
            navigationController.navigationItem.backBarButtonItem = backItem
            navigationController.pushViewController(weatherLookupVC, animated: true)
        }
    }
    
    func startWeatherInfo(hourly: Hourly) {
        let weatherInfoCoordinator = WeatherInfoCoordinator(navigationController: navigationController, hourly: hourly)
        childCoordinators.append(weatherInfoCoordinator)
        weatherInfoCoordinator.start()
    }
}
