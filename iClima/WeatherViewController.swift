//
//  ViewController.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    //MARK: LOGICAL ENTITIES
    let networkService = NetworkService()
    let locationManager = CLLocationManager()
    let defaultCity = CityLocation(name: "Montevideo", longitude: nil, latitude: nil)
    var currentCity: CityLocation? {
        didSet {
            // Get the data of this city
            getTheWeather()
        }
    }
    
    //MARK: UI VARIABLES
    let stackViewItems = StackItemView()
    let weatherImage = UIImageView()
    let weatherValue = WeatherLabel()
    let buttonSelectCity = UIButton()
    let loadingView = LoadingView()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        askForPermission()
        retriveCurrentLocation()
        setUpNavigationBar()
        configureInitialUI()
    }
    
    //MARK: UI SET UP
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    func configureInitialUI(){
        //Background gradient - image
        if let gradientImage = UIImage(named: "gradient-2.png") {
            self.view.backgroundColor = UIColor(patternImage: gradientImage)
        }else{
            self.view.backgroundColor = UIColor.blue
        }
        //Create ui interface items
        //Image of the weather
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        //Middle stack view items
        stackViewItems.translatesAutoresizingMaskIntoConstraints = false
        //Button of city selection
        buttonSelectCity.setTitle("SELECT OTHER CITY", for: .normal)
        buttonSelectCity.addTarget(self, action: #selector(showCityList), for: .touchUpInside)
        buttonSelectCity.translatesAutoresizingMaskIntoConstraints = false
        // Place the ui interface items
        view.addSubview(weatherValue)
        view.addSubview(weatherImage)
        view.addSubview(stackViewItems)
        view.addSubview(buttonSelectCity)
        view.addSubview(loadingView)
        //Set the anchors constrains
        weatherValue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherValue.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        weatherImage.widthAnchor.constraint(equalToConstant: 88).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 88).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherImage.topAnchor.constraint(equalTo: weatherValue.bottomAnchor, constant: 16).isActive = true
        
        stackViewItems.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewItems.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 54).isActive = true
        
        buttonSelectCity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonSelectCity.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //Setup the interface with default city info
        currentCity = defaultCity
    }
    
    //MARK: METHODS
    func getTheWeather(){
        loadingView.loading = true
        networkService.getWeatherData(of: currentCity) { (weather, completed, errorMessage) in
            if(completed){
                if let weather = weather {
                    print(weather)
                    self.updateViews(weather: weather)
                }
            }else{
                //Show error
                print(errorMessage)
            }
            self.loadingView.loading = false
        }
    }
    func updateViews(weather: Weather){
        self.title = weather.name
        weatherValue.temperature = weather.main.temp
        stackViewItems.maxTemp = weather.main.temp_max
        stackViewItems.minTemp = weather.main.temp_min
        stackViewItems.wind = weather.wind.speed
        if(weather.weather.count > 0){
            setImageOfWeather(from: weather.weather[0].icon)
        }
    }
    func setImageOfWeather(from icon: String) {
        networkService.getImageFromUrl(from: icon){ data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.weatherImage.image = UIImage(data: data)
            }
        }
    }
    @objc func showCityList(sender: UIButton!) {
        let vc = CityListViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}
//MARK: CITY SELECTION
extension WeatherViewController: SetCitySelection {
    func selectedcity(city: CityLocation) {
        if(city.name != nil){
            currentCity = city
        }else{
            retriveCurrentLocation()
        }
    }
}

//MARK: CURRENT LOCATION STUFF
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error on location: \(error.localizedDescription)")
        loadingView.loading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        @unknown default:
            print("Defaul error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        loadingView.loading = false
        if let location = locations.first {
            currentCity = CityLocation(name: nil, longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
        }
    }
    
    func retriveCurrentLocation(){
        locationManager.delegate = self
        loadingView.loading = true
        let status = CLLocationManager.authorizationStatus()
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            loadingView.loading = false
            return
        }
        if(status == .notDetermined){
            loadingView.loading = false
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.requestLocation()
    }
    func askForPermission(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
}

