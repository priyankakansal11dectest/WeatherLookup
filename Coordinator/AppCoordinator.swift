import UIKit

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let locationSearchCoordinator = LocationSearchCoordinator(navigationController: navigationController)
        childCoordinators.append(locationSearchCoordinator)
        locationSearchCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

