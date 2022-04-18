import Foundation

class LocationSearchViewModel {
    
    weak var coordinator: LocationSearchCoordinator?
    
    private var locationSearchNetworkServiceProtocol: LocationSearchNetworkServiceProtocol
    var locationListDidUpdate: (() -> Void)?
    
    var locationList: [Location]! {
        didSet {
            self.locationListDidUpdate?()
        }
    }
    
    init(locationSearchNetworkServiceProtocol: LocationSearchNetworkServiceProtocol) {
        self.locationSearchNetworkServiceProtocol = locationSearchNetworkServiceProtocol
    }
    
    func loadLocationList(cityName: String) {
        locationSearchNetworkServiceProtocol.loadLocationList(cityName: cityName) { result in
            switch result {
            case .success(let locationList):
                self.locationList = locationList
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goToWeatherLookUpVC(location: Location) {
        coordinator?.startWeatherLookup(location: location)
    }
}
