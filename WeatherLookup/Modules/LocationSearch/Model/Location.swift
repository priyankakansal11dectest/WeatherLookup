import Foundation

struct Location: Codable {
    let name: String
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
    }
}
