import UIKit

final class LocationSearchCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Api Client Dependency
    private var locationSearchNetworkService: LocationSearchNetworkServiceProtocol {
        return LocationSearchService()
    }
    
    func start() {
        // Instantiate LocationSearchViewController
        if let locationSearchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchViewController") as? LocationSearchViewController {
            // Instantiate LocationSearchViewModel with Service dependecy
            let locationSearchVM = LocationSearchViewModel(locationSearchNetworkServiceProtocol: locationSearchNetworkService)
            locationSearchVM.coordinator = self
            // Set the ViewModel to ViewController
            locationSearchVC.viewModel = locationSearchVM
            navigationController.setViewControllers([locationSearchVC], animated: false)
        }
    }
    
    func startWeatherLookup(location: Location) {
        let weatherLookupCoordinator = WeatherLookupCoordinator(navigationController: navigationController, location: location)
        childCoordinators.append(weatherLookupCoordinator)
        weatherLookupCoordinator.start()
    }
}
