//
//  WeatherManager.swift
//  _7. Clima-SUI
//
//  Created by Андрей Бородкин on 18.02.2023.
//

import Foundation


final class WeatherManager: ObservableObject {
    
    
    @Published var fetchedWeather = WeatherModel(conditionID: 800, cityName: "London", temperature: 26)
    @Published var error: Error?
        
    var weatherURl = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURl)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let url = URL(string: urlString)
        
        guard let url = url else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                if let weather = self.parseJSON( safeData) {
                    DispatchQueue.main.async {
                        self.fetchedWeather = weather
                     }
                }
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
          let decodedData = try  decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            self.error = error
            return nil
        }
        
    }
    
   
    
}
