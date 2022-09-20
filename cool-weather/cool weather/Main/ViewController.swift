//
//  ViewController.swift
//  cool weather
//
//  Created by Matthew on 23.06.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var plusButton: UIButton!

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var weatherIconView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var currentCItyLabel: UILabel!
    
    
    // Прогноз на завтра
    @IBOutlet weak var tomorrowButton: UIButton!
    
    @IBOutlet weak var tomorrowMaxTempLabel: UILabel!
    @IBOutlet weak var tomorrowMinTempLabel: UILabel!
    @IBOutlet weak var tomorrowChanceOfRainLabel: UILabel!
    
    
    // Прогноз на после-завтра
    
    @IBOutlet weak var secondDayButton: UIButton!
    
    @IBOutlet weak var secondDayMaxTempLabel: UILabel!
    @IBOutlet weak var secondDayMinTempLabel: UILabel!
    @IBOutlet weak var secondDayChanceOfRainLabel: UILabel!
    
    // Прогноз на послеПосле-завтра
    @IBOutlet weak var thirdDayButton: UIButton!
    
    @IBOutlet weak var thirdDayMaxTempLabel: UILabel!
    @IBOutlet weak var thirdDayMinTempLabel: UILabel!
    @IBOutlet weak var thirdDayChanceOfRainLabel: UILabel!
    
    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    
    @IBOutlet weak var getDataButton: UIButton!
    
    var city: String = "Moscow"
    var date: String = ""
    var geoButtonPress: Bool = false
    
    
    var day: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

        change()
        
        currentCItyLabel.text = city
    
    }
    

    
    func change() {
        
        if geoButtonPress == true {
            self.city = "Maloye+Medvezhino"
            
        }
    }
    
    private func dates() {
        
        let today = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        
        if let todayD = today.today {
            let todayString = dateFormatter.string(from: todayD)
            self.tomorrowButton.setTitle("\(todayString)", for: .normal)
            //self.tomorrowDateLabel.text = "\(todayString)"
            print("Today is:",todayString)
        }
        
        if let tomorrow = today.tomorrow {
            let tomorrowString = dateFormatter.string(from: tomorrow)
            self.secondDayButton.setTitle("\(tomorrowString)", for: .normal)
            //self.secondDayDateLabel.text = "\(tomorrowString)"
            print("Tomorrow is: \(tomorrowString)")
        }
        
        if let tomorrow2 = today.theDayAfterTomorrow {
            let tomorrowString1 = dateFormatter.string(from: tomorrow2)
            self.thirdDayButton.setTitle("\(tomorrowString1)", for: .normal)
            //self.thirdDayDateLabel.text = "\(tomorrowString1)"
            
            print("The day after tomorrow is: \(tomorrowString1)")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadCurrentWeather()
        loadFutureWeather()
        loadAstroWeather()
        
         
    }
    
    
    func dayOrNightBackgroundImage() {
        
    }

    @IBAction func getDataButtonPressed(_ sender: UIButton) {
        

        print(city)
        
        alertChangeCity()
        
        
        print(city)
        //loadCurrentWeather()
    }
    
    private func loadCurrentWeather() {
        
        var url = self.city
        print("Проверка что грузит",url)
        
        
        let urlCurrentWeather = URL(string:
                                        "https://api.weatherapi.com/v1/current.json?key=bc478a25a10e42a6b7464825222406&q=\(url)&aqi=no")!
        
        let session = URLSession(configuration: .default)
        
        let dataTask =  session.dataTask(with: urlCurrentWeather) { data, response, error in
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
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)

                DispatchQueue.main.async {
                    
                    //self.cityNameLabel.text = "Today in: \(weatherResponse.location.name)"
                    let cityNamelabelString = "todayInCityLabelText".localized()
                    let cityNameLabelApi = weatherResponse.location.name
                    self.cityNameLabel.text = String.localizedStringWithFormat(cityNamelabelString + cityNameLabelApi)
                     
                    
                    self.countryNameLabel.text = weatherResponse.location.country
                    
                    //self.tempLabel.text = "Temp is: \(weatherResponse.current.temp_c) ℃"
                    let tempLabelString = "tempIsLabelText".localized()
                    let currentTempApi: String = "\(weatherResponse.current.temp_c)"
                    let celsiusCaracter = " ℃"
                    self.tempLabel.text = String.localizedStringWithFormat(tempLabelString + currentTempApi + celsiusCaracter)
                    
                    
                    //self.uvIndexLabel.text = "UV index is: \(weatherResponse.current.uv)"
                    let uvIndexLabelString = "uvIndexIsText".localized()
                    let uvIndexApi: String = "\(weatherResponse.current.uv)"
                    self.uvIndexLabel.text = String.localizedStringWithFormat(uvIndexLabelString + uvIndexApi)
                    
                    
                    if let url = URL(string: "https:\(weatherResponse.current.condition.icon)") {
                        print("https:\(weatherResponse.current.condition.icon)")
                            self.loadImage(with: url)
                         
                    } else {
                        //completion()
                    }
                    
                    print(weatherResponse.current.is_day)
                    
                    // Смена дня и ночи
                    if weatherResponse.current.is_day == 1 {
                        self.day = true
                        self.backgroundImageView.image = UIImage(named: "Afternoon")
                        print("Day backgroung is set")
                        self.cityNameLabel.textColor = .systemIndigo
                        self.countryNameLabel.textColor = .systemIndigo
                        self.tempLabel.textColor = .systemIndigo
                        self.uvIndexLabel.textColor = .systemIndigo
                        self.sunsetLabel.textColor = .systemIndigo
                        self.sunriseLabel.textColor = .systemIndigo
                    } else {
                        self.day = false
                        self.backgroundImageView.image = UIImage(named: "Night")
                        print("Night backgroung is set")
                        self.cityNameLabel.textColor = .systemOrange
                        self.countryNameLabel.textColor = .systemOrange
                        self.tempLabel.textColor = .systemOrange
                        self.uvIndexLabel.textColor = .systemOrange
                        self.sunsetLabel.textColor = .systemOrange
                        self.sunriseLabel.textColor = .systemOrange
                    }
                    

                }
            } catch {
                debugPrint("errr?",error.localizedDescription)
                //completion()
            }
        }
        
        dataTask.resume()
    }
    
    
    private func loadFutureWeather() {
        
        var url = self.city
        print("Проверка что грузит",url)
        
        let urlFutureWeather = URL(string:
                                        "https://api.weatherapi.com/v1/forecast.json?key=bc478a25a10e42a6b7464825222406&q=\(url)&days=3&aqi=no&alerts=no")!
        
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
                    
                    
                    self.dates()
                    
                    //self.tomorrowDateLabel.text = weatherFutureResponse.forecast.forecastday[0].date
                    self.tomorrowMaxTempLabel.text = "Max ℃ \(weatherFutureResponse.forecast.forecastday[0].day.maxtemp_c)"
                    self.tomorrowMinTempLabel.text = "Min ℃ \(weatherFutureResponse.forecast.forecastday[0].day.mintemp_c)"
                    self.tomorrowChanceOfRainLabel.text = "🌧 \(weatherFutureResponse.forecast.forecastday[0].day.daily_chance_of_rain)%"
                   
                    //self.secondDayDateLabel.text = weatherFutureResponse.forecast.forecastday[1].date
                    self.secondDayMaxTempLabel.text = "Max ℃ \(weatherFutureResponse.forecast.forecastday[1].day.maxtemp_c)"
                    self.secondDayMinTempLabel.text = "Min ℃ \(weatherFutureResponse.forecast.forecastday[1].day.mintemp_c)"
                    self.secondDayChanceOfRainLabel.text = "🌧 \(weatherFutureResponse.forecast.forecastday[1].day.daily_chance_of_rain)%"
                    
                    //self.thirdDayDateLabel.text = weatherFutureResponse.forecast.forecastday[2].date
                    self.thirdDayMaxTempLabel.text = "Max ℃ \(weatherFutureResponse.forecast.forecastday[2].day.maxtemp_c)"
                    self.thirdDayMinTempLabel.text = "Min ℃ \(weatherFutureResponse.forecast.forecastday[2].day.mintemp_c)"
                    self.thirdDayChanceOfRainLabel.text = "🌧 \(weatherFutureResponse.forecast.forecastday[2].day.daily_chance_of_rain)%"
                
                }
            } catch {
                debugPrint("errr?",error.localizedDescription)
                //completion()
            }
        }
        
        dataTask.resume()
    }
    
    
    private func loadAstroWeather() {
        
        var url = self.city
        print("Проверка что грузит",url)
        
        let urlAstroWeather = URL(string: "https://api.weatherapi.com/v1/astronomy.json?key=bc478a25a10e42a6b7464825222406&q=\(url)&dt=\(date)")!
        
        let session = URLSession(configuration: .default)
        
        let dataTask =  session.dataTask(with: urlAstroWeather) { data, response, error in
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
                let astroWeatherResponse = try JSONDecoder().decode(AstroWeatherResponse.self, from: data)

                
                DispatchQueue.main.async {
                    
                   // self.sunriseLabel.text = "Sunrise: \(astroWeatherResponse.astronomy.astro.sunrise)"
                    let sunriseLabelString = "sunriseLabelText".localized()
                    let astroSunriseApi: String = "\(astroWeatherResponse.astronomy.astro.sunrise)"
                    self.sunriseLabel.text = String.localizedStringWithFormat(sunriseLabelString + astroSunriseApi)
                    
                    
                    //self.sunsetLabel.text = "Sunset: \(astroWeatherResponse.astronomy.astro.sunset)"
                    let sunsetLabelString = "sunsetLabelText".localized()
                    let astroSunsetApi: String = "\(astroWeatherResponse.astronomy.astro.sunset)"
                    
                    self.sunsetLabel.text = String.localizedStringWithFormat(sunsetLabelString + astroSunsetApi)
                    
                }
            } catch {
                debugPrint("errr?",error.localizedDescription)
                //completion()
            }
        }
        
        dataTask.resume()
    }
    
    func citySave() {
        
        print("Будем сохранять;",self.city)
        currentCItyLabel.text = city
        UserDefaults.standard.set(self.city, forKey: "saveCity")
        print("Сохранено в дефолтс",UserDefaults.standard.string(forKey: "saveCity")!)
        
    }
    
    private func loadImage(with url: URL) {
        URLSession(configuration: .default).dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    print("Image was set")
                    self.weatherIconView.image = image
                    //completion()
                }
            } else {
                //completion()
            }
        }.resume()
    }
    

        func alertChangeCity() {
    
            let alertUserName = UIAlertController(title: "Change city!", message: "Type wisely", preferredStyle: .alert)
    
            alertUserName.addTextField(configurationHandler: { textField in
                let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
                textField.placeholder = cities.randomElement()
                //textField.isSecureTextEntry = true
                textField.clearButtonMode = .always
            })
    
            let ok = UIAlertAction(title: "Enter!", style: .default, handler: { (action) -> Void in
                print("----------------------")
                print("City is changed")
                self.city = alertUserName.textFields?.first?.text?.replacingOccurrences(of: " ", with: "+") ?? "Stambul"
                self.loadCurrentWeather()
                self.loadFutureWeather()
                self.loadAstroWeather()
                self.currentCItyLabel.text = self.city
                self.citySave()
                
                 
            })
    
            alertUserName.addAction(ok)
    
            present(alertUserName, animated: true)
        }
    
    
    @IBAction func tomorrowButtonPressed(_ sender: UIButton) {
        
        let firstDayViewController = FirstDayViewController.instantiate()
        
        present(firstDayViewController, animated: true)
        
    }
    
    @IBAction func secondDayButtonPressed(_ sender: UIButton) {
        
        let secondDayViewController = SecondDayViewController.instantiate()
        
        present(secondDayViewController, animated: true)
    }
    
    
    
    @IBAction func thirdDayButtonPressed(_ sender: UIButton) {
        let thirdDayViewController = ThirdDayViewController.instantiate()
        
        present(thirdDayViewController, animated: true)
    }
    
    
    @IBAction func heartButtonPressed(_ sender: UIButton) {
        
        
        let citiesViewController = CitiesViewController.instantiate()
        
        present(citiesViewController, animated: true)
    }
    
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        
        
        
    }

    
    @IBAction func geoButtonPressed(_ sender: UIButton) {
        
        geoButtonPress = true
        
        LocationManager.shared.getUserLocation { location in
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            UserDefaults.standard.set(lat, forKey: "Latitude")
            UserDefaults.standard.set(lon, forKey: "Longitude")
            
            let urlCurrentWeather = URL(string:
                                            "https://api.weatherapi.com/v1/current.json?key=bc478a25a10e42a6b7464825222406&q=\(UserDefaults.standard.double(forKey: "Latitude")),\(UserDefaults.standard.double(forKey: "Longitude"))&aqi=no")!
            
            let session = URLSession(configuration: .default)
            
            let dataTask =  session.dataTask(with: urlCurrentWeather) { data, response, error in
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
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)

                    
                    DispatchQueue.main.async { [self] in
                        
                        
                        print("City name is!!!!!:",weatherResponse.location.name)
                        self.city = weatherResponse.location.name.replacingOccurrences(of: " ", with: "+")
                        print(self.city)
                        loadCurrentWeather()
                        loadFutureWeather()
                        loadAstroWeather()
                        citySave()
                        
                        
                    }
                } catch {
                    debugPrint("errr?",error.localizedDescription)
                    //completion()
                }
            }
            
            dataTask.resume()
            
   
            
        }
        
    }
    
}

