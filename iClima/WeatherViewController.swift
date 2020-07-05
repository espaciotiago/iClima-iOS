//
//  ViewController.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: VARIABLES
    let networkService = NetworkService()
    let stackViewItems = StackItemView()
    let weatherImage = UIImageView()
    let weatherValue = WeatherLabel()
    let buttonSelectCity = UIButton()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let gradientImage = UIImage(named: "gradient.png") {
            self.view.backgroundColor = UIColor(patternImage: gradientImage)
        }else{
            self.view.backgroundColor = UIColor.blue
        }
        //Create ui interface items
        //Image of the weather
        weatherImage.translatesAutoresizingMaskIntoConstraints = false;
        //Middle stack view items
        stackViewItems.translatesAutoresizingMaskIntoConstraints = false;
        //Button of city selection
        buttonSelectCity.setTitle("SELECT OTHER CITY", for: .normal)
        buttonSelectCity.translatesAutoresizingMaskIntoConstraints = false;
        // Place the ui interface items
        view.addSubview(weatherValue)
        view.addSubview(weatherImage)
        view.addSubview(stackViewItems)
        view.addSubview(buttonSelectCity)
        //Set the anchors constrains
        weatherValue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherValue.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherImage.topAnchor.constraint(equalTo: weatherValue.bottomAnchor, constant: 8).isActive = true
        
        stackViewItems.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewItems.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 16).isActive = true
        
        buttonSelectCity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonSelectCity.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        //Setup the interface with default city info
        if let urlImage = URL(string: "https://openweathermap.org/img/w/04d.png"){
            setImageOfWeather(from: urlImage)
        }
        weatherValue.temperature = 279
    }
    
    //MARK: METHODS
    func getMyCurrentLocation(){
        
    }
    
    func getTheWeatherBy(cityName: String){
        
    }
    
    func getTheWeatherBy(latitude: Double, longitude: Double){
        
    }
    
    func updateViews(){
        
    }
    
    func setImageOfWeather(from url: URL) {
        networkService.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.weatherImage.image = UIImage(data: data)
            }
        }
    }
    
}

