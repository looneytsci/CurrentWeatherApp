//
//  button.swift
//  CurrentWeatherApp
//
//  Created by Дмитрий Головин on 17.05.2021.
//

import Foundation
import UIKit

extension ViewController {
    
    override func loadView() {
        super.loadView()
        
        addMainCityButton.layer.cornerRadius = 10
        addMainCityButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addMainCityButton.layer.shadowRadius = 3
        addMainCityButton.layer.shadowOpacity = 0.3
        statusLabel.alpha = 0
    }
}
