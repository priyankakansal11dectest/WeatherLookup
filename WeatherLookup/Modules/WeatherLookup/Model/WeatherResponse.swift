import Foundation

struct WeatherResponse: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let hourly: [Hourly]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case hourly
    }
}
