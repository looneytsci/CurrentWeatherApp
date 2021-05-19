//
//  LocationManagerDelegate.swift
//  CurrentWeatherApp
//
//  Created by Дмитрий Головин on 19.05.2021.
//

import Foundation
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        LocationManager.getPlacemark(location: location) { placemark, error in
            if let err = error {
                print(err)
            } else if let placemark = placemark {
                self.locationCity = placemark.locality
                print(self.locationCity!)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
}

