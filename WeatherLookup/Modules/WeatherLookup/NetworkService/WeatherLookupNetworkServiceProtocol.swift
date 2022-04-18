import Foundation

protocol WeatherLookupNetworkServiceProtocol {
    func loadWeather(location: Location, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}
