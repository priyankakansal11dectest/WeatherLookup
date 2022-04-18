import Foundation

protocol LocationSearchNetworkServiceProtocol {
    func loadLocationList(cityName: String, completion: @escaping (Result<[Location], Error>) -> Void)
}
