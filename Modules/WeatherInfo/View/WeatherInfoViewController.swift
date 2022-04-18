import UIKit

class WeatherInfoViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    
    var hourly: Hourly!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let hourly = hourly  {
            temperatureLabel.text = String(format: " Temperature: %.0f °C", hourly.temp)
            feelsLikeLabel.text =  String(format: " Feels like: %.0f °C", hourly.feelsLike)
            weatherLabel.text = String(hourly.weather.first?.main ?? "")
            weatherDescLabel.text = String(hourly.weather.first?.weatherDescription ?? "")
        }
    }
}
