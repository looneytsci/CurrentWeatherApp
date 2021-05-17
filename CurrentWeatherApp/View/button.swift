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

extension ViewController {
    func addCityWithAnimation(with city: String) {
        statusLabel.textColor = .white
        statusLabel.text = "\(city) теперь основной город!"
        Weather.mainCity = city
        print("новый город установлен")
        UIView.animate(withDuration: 1) { [weak self] in
            self?.statusLabel.alpha = 1
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 1) {
                self?.statusLabel.alpha = 0
            }
        }
    }
}
