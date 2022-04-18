import Foundation

class WeatherLookupViewModel {
    
    weak var coordinator: WeatherLookupCoordinator?
    
    private var weatherLookupNetworkServiceProtocol: WeatherLookupNetworkServiceProtocol
    var weatherDataDidUpdate: ((WeatherResponse) -> Void)?

    var weatherData: WeatherResponse! {
        didSet {
            if let weatherData = weatherData {
                self.weatherDataDidUpdate?(weatherData)
            }
        }
    }
    
    init(weatherLookupNetworkServiceProtocol: WeatherLookupNetworkServiceProtocol) {
        self.weatherLookupNetworkServiceProtocol = weatherLookupNetworkServiceProtocol
    }
    
    func loadWeather(location: Location) {
        weatherLookupNetworkServiceProtocol.loadWeather(location: location) { result in
            switch result {
            case .success(let data):
                self.weatherData = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goToWeatherInfoVC(hourly: Hourly) {
        coordinator?.startWeatherInfo(hourly: hourly)
    }
}
