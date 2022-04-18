import UIKit

final class WeatherInfoCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let hourly: Hourly
    
    init(navigationController: UINavigationController, hourly: Hourly) {
        self.navigationController = navigationController
        self.hourly = hourly
    }
    
    func start() {
        // Instantiate WeatherInfoViewController
        if let weatherInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherInfoViewController") as? WeatherInfoViewController {
            weatherInfoVC.hourly = hourly
            navigationController.pushViewController(weatherInfoVC, animated: true)
        }
    }
}
