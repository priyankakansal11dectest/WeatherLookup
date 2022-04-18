import Foundation

enum Endpoint {
    
    case locationList(cityName: String)
    case weatherData(location: Location)
    
    var urlString: String {
        switch self {
        case .locationList:
            return API.GeoDirectURL
        case .weatherData:
            return API.OneCallURL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .locationList:
            return .get
        case .weatherData:
            return .get
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .locationList(let cityName):
            return [
                "q": cityName,
                "limit": "10",
                "appid": API.Key
            ]
            
        case .weatherData(let location):
            return [
                "units": "metric",
                "appid": API.Key,
                "exclude": "current,minutely,daily,alerts",
                "lat": String(location.lat),
                "lon": String(location.lon)
            ]
        }
    }
    
    var headers : [String: Any] {
            switch self {
            default:
                return [:]
            }
        }
    
}
