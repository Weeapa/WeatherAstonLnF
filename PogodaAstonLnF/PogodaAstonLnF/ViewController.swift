//
//  ViewController.swift
//  PogodaAstonLnF
//
//  Created by Калякин Дима  on 05.12.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController  {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var idIconLabel: UIImageView!
    
    let locationManager = CLLocationManager()
    var weatherData = WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        startLocationManager()
    }
    
    func updateWeatherInfo(latitude:Double, longitude:Double){
        let session = URLSession.shared

        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&appid=b7594745e57435fd7b5d51e999f1e0a8")!

        let task = session.dataTask(with: url){( data, response, error) in
            guard error == nil else {
                print("DataTask error= \(error?.localizedDescription)")
                return
            }
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                print(self.weatherData)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch  {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
    
    
    func updateView(){
        cityLabel.text = weatherData.name
        weatherDescriptionLabel.text = DataSource.weatherIDs[weatherData.weather[0].id]
        tempLabel.text = weatherData.main.temp.description + "C"
        idIconLabel.image = UIImage(named: weatherData.weather[0].icon)
    }
    
    
    func startLocationManager (){
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}
