import Foundation

class WeatherLookupService: WeatherLookupNetworkServiceProtocol {
    
    let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    
    func loadWeather(location: Location, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        serviceManager.callService(endpoint: .weatherData(location: location)) { (response: WeatherResponse) in
            let weatherData = response
            completion(.success(weatherData))
        } fail: { error in
            completion(.failure(error))
        }
    }
}
