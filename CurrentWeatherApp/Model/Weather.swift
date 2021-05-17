//
//  Weather.swift
//  CurrentWeatherApp
//
//  Created by Дмитрий Головин on 17.05.2021.
//

import Foundation
import UIKit

class Weather {
    var name: String? = nil
    var main: [String: Double]? = nil
    var weather: [String: Any]? = nil
    var weatherDescription: String? = nil
    
    static var mainCity: String? {
        didSet {
            UserDefaults.standard.set(mainCity, forKey: "MainCity")
        }
    }
    
    func kelvinToCels(temp: Double) -> Double {
        let newTemp = temp - 273.15
        return newTemp
    }
    
    
}
