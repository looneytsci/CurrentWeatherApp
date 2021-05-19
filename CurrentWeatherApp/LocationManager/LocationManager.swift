//
//  File.swift
//  CurrentWeatherApp
//
//  Created by Дмитрий Головин on 19.05.2021.
//

import Foundation
import CoreLocation

class LocationManager {
 
    static func getPlacemark(location: CLLocation, completionHandler: @escaping ((_ placemark: CLPlacemark?,_ error: String?) -> ())) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completionHandler(nil, error.localizedDescription)
            } else if let placemarksArray = placemarks {
                if let placemark = placemarksArray.first {
                    completionHandler(placemark, nil)
                } else {
                completionHandler(nil, "Placemark was nil")
                }
            } else {
                completionHandler(nil, "Unknown error")
            }
        
    }
    
}
}

