//
//  FirstDayViewController.swift
//  cool weather
//
//  Created by Matthew on 19.09.22.
//

import UIKit

class FirstDayViewController: UIViewController {

    var city: String = UserDefaults.standard.string(forKey: "saveCity")!
    
    
    @IBOutlet private weak var dayNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var conditionsLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var chanceOfRainLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFutureWeather()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    private func loadFutureWeather() {
        
        
        let cityForUrl = city
        
        let urlFutureWeather = URL(string:
                                        "https://api.weatherapi.com/v1/forecast.json?key=bc478a25a10e42a6b7464825222406&q=\(cityForUrl)&days=3&aqi=no&alerts=no")!
        
        let session = URLSession(configuration: .default)
        
        let dataTask =  session.dataTask(with: urlFutureWeather) { data, response, error in
            //print(response)
            if let error = error {
                print("err??",error.localizedDescription)
                //completion()
                return
            }
            guard let data = data else {
                //completion()
                return
            }
            
            print("Data is:", data)
            
            do {
                let weatherFutureResponse = try JSONDecoder().decode(WeatherFutureResponse.self, from: data)

                
                DispatchQueue.main.async {
                    
                    if let url = URL(string: "https:\(weatherFutureResponse.forecast.forecastday[0].day.condition.icon)") {
                        //print("https:\(weatherResponse.current.condition.icon)")
                            self.loadImage(with: url)
                         
                    } else {
                        //completion()
                    }
                    
                    
                    
                    self.dates()
                    
                        //self.dayNameLabel. text =
                        self.dateLabel.text = "\(weatherFutureResponse.forecast.forecastday[0].date)"
                    self.conditionsLabel.text = "\(weatherFutureResponse.forecast.forecastday[0].day.condition.text)"
                    
                        //self.imageView.text =
                        
                    self.maxTempLabel.text = "Max temp \(weatherFutureResponse.forecast.forecastday[0].day.maxtemp_c)℃"
                    self.minTempLabel.text = "Min temp \(weatherFutureResponse.forecast.forecastday[0].day.mintemp_c)℃"
                    self.chanceOfRainLabel.text = "Chance of rain 🌧 is:  \(weatherFutureResponse.forecast.forecastday[0].day.daily_chance_of_rain)%"
                    self.windLabel.text = " Wind will be 💨: \(weatherFutureResponse.forecast.forecastday[0].day.maxwind_kph)k/ph"
                    self.humidityLabel.text = "Humidity level will be 💦: \(weatherFutureResponse.forecast.forecastday[0].day.avghumidity)%"
                    
                    
                
                
                    
                    //self.tomorrowDateLabel.text = weatherFutureResponse.forecast.forecastday[0].date
//                    self.tomorrowMaxTempLabel.text = "Max ℃ \(weatherFutureResponse.forecast.forecastday[0].day.maxtemp_c)"
//                    self.tomorrowMinTempLabel.text = "Min ℃ \(weatherFutureResponse.forecast.forecastday[0].day.mintemp_c)"
//                    self.tomorrowChanceOfRainLabel.text = "🌧 \(weatherFutureResponse.forecast.forecastday[0].day.daily_chance_of_rain)%"
                   

                }
            } catch {
                debugPrint("errr?",error.localizedDescription)
                //completion()
            }
        }
        
        dataTask.resume()
    }
    
    
    
    private func dates() {
        
        let today = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        
        if let todayD = today.today {
            let todayString = dateFormatter.string(from: todayD)
            
            self.dayNameLabel.text = "Forecast for: \(todayString)"
            print("Forecast for:",todayString)
        }
        

        
    }
    
    
    private func loadImage(with url: URL) {
        URLSession(configuration: .default).dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    print("Image was set")
                    self.imageView.image = image
                    //completion()
                }
            } else {
                //completion()
            }
        }.resume()
    }
    


}
