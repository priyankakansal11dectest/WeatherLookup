import Foundation

class LocationSearchService: LocationSearchNetworkServiceProtocol {
    
    let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    
    func loadLocationList(cityName: String, completion: @escaping (Result<[Location], Error>) -> Void) {
        
        serviceManager.callService(endpoint: .locationList(cityName: cityName)) { (response: [Location]) in
            let locationList =  response
            completion(.success(locationList))
        } fail: { error in
            completion(.failure(error as Error))
        }
    }
}
