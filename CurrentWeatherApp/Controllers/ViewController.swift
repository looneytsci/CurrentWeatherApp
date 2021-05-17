//
//  ViewController.swift
//  CurrentWeatherApp
//
//  Created by Дмитрий Головин on 17.05.2021.
//

import UIKit

enum weatherType: String {
    case Thunderstome = "cloud.bolt"
    case Drizzle = "cloud.drizzle"
    case Rain = "cloud.heavyrain"
    case Snow = "cloud.snow"
    case Athmosphere = "wind"
    case Clear = "sun.max"
    case Clouds = "cloud"
}

class ViewController: UIViewController {

    var weather: Weather?
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var addMainCityButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        
        if let city = UserDefaults.standard.string(forKey: "MainCity") {
            print(city)
            fetchData(on: city)
        } else {
            fetchData(on: "petersburg")
        }
        
        
    }
    
    // MARK: @IB Actions

    @IBAction func searchCity(_ sender: UIButton) {
        guard let cityName = textField.text,
              !cityName.isEmpty
        else {
            print("Fail")
            return
        }
        
        fetchData(on: cityName)
        view.endEditing(true)
        textField.text = ""
    }
    
    @IBAction func addMainCity(_ sender: UIButton) {
        
        
        let city = cityName.text
        if let mainCity = UserDefaults.standard.string(forKey: "MainCity") {
            if city == mainCity {
                statusLabel.textColor = .red
                statusLabel.text = "Город уже установлен как основной"
                
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.statusLabel.alpha = 1
                } completion: { [weak self] _ in
                    UIView.animate(withDuration: 1) {
                        self?.statusLabel.alpha = 0
                    }

                }

            } else {
                statusLabel.textColor = .white
                guard let city = city else { return }
                statusLabel.text = "\(city) теперь основной город!"
                Weather.mainCity = city
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.statusLabel.alpha = 1
                } completion: { [weak self] _ in
                    UIView.animate(withDuration: 1) {
                        self?.statusLabel.alpha = 0
                    }
                }
                
                

            }
        }
        
        
        
    }
    
    // MARK: Networking
    
    func fetchData(on city: String) {
        let startUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7b843178730ba2c68fc10a5ff17023d3"
        NetworkManager.fetchData(url: startUrl) { [weak self] weather in
            DispatchQueue.main.async {
                guard let temp = weather.main?["temp"],
                      let cityName = weather.name,
                      let weatherDescription = weather.weather?["description"] as? String else {
                    let ac = UIAlertController(title: "Ошибка", message: "Город введен неверно", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Снова", style: .default, handler: nil))
                    self?.present(ac, animated: true, completion: nil)
                    self?.textField.text = ""
                    return
                    
                }
                
                guard let weatherId = weather.weather?["id"] as? Int else { return }
                var weatherImage: String = ""
                
                switch weatherId {
                case 200...232:
                    weatherImage = weatherType.Thunderstome.rawValue
                case 300...321:
                    weatherImage = weatherType.Drizzle.rawValue
                case 500...531:
                    weatherImage = weatherType.Rain.rawValue
                case 600...622:
                    weatherImage = weatherType.Snow.rawValue
                case 701...781:
                    weatherImage = weatherType.Athmosphere.rawValue
                case 800:
                    weatherImage = weatherType.Clear.rawValue
                case 801...804:
                    weatherImage = weatherType.Clouds.rawValue
                default:
                    break
                }
                print(weatherImage)
                
                let celcTemp = Int(weather.kelvinToCels(temp: temp))
                
                DispatchQueue.main.async {
                    self?.tempLabel.text = "\(celcTemp)°"
                    self?.desciptionLabel.text = weatherDescription
                    self?.cityName.text = cityName
                    self?.weatherImage.image = UIImage(systemName: weatherImage)
                    self?.weatherImage.tintColor = .white
                }
            }
        }
    }
    
    // MARK: Keyboard settings
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let cityName = textField.text,
              !cityName.isEmpty
        else {
            print("Fail")
            return false
        }
        
        fetchData(on: cityName)
        view.endEditing(true)
        textField.text = ""
        return true
    }
}

