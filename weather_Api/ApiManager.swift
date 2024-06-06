//
//  ApiManager.swift
//  weather_Api
//
//  Created by Admin on 28/05/24.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    let urlString =  "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&past_days=10&hourly=temperature_2m"
    
    
    func getWeather(completion: @escaping ([Double]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            if let wetherData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                //print("success decoding or прошел успешно")
                completion(wetherData.hourly.temperature2M)
            } else {
                print("Fail or не успешно")
            }
        }
        task.resume()
        
    }
}
