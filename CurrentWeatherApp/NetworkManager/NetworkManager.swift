//
//  NetworkManager.swift
//  CurrentWeatherApp
//
//  Created by Дмитрий Головин on 17.05.2021.
//

import Foundation
import UIKit

class NetworkManager {
    
    private let apiKey = "7b843178730ba2c68fc10a5ff17023d3"
    
    static func fetchData(url: String, completion: @escaping (_ weather: Weather) -> ()) {
        guard let url = URL(string: url) else {
            print("fail")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let currentWeather = Weather()
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        
                        
                        if let main = json["main"] as? [String: Any] {
                            currentWeather.main = main as? [String: Double]
                        }
                        
                        if let weather = json["weather"] as? NSArray {
                            if let value = weather.firstObject as? NSDictionary {
                                currentWeather.weather = value as? [String: Any]
                            }
                        }
                        
                        if let cityName = json["name"] as? String {
                            currentWeather.name = cityName
                        }
                    } else {
                        print("fail")
                    }
                    completion(currentWeather)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
