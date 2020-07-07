//
//  CityListViewController.swift
//  iClima
//
//  Created by Santiago Moreno on 6/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import UIKit

protocol SetCitySelection {
  func selectedcity(city: CityLocation)
}

class CityListViewController: UIViewController {
    //MARK: LOGICAL ENTITIES
    let cities = [
        CityLocation(name: "Montevideo", longitude: nil, latitude: nil),
        CityLocation(name: "Londres", longitude: nil, latitude: nil),
        CityLocation(name: "Sao Paulo", longitude: nil, latitude: nil),
        CityLocation(name: "Buenos aires", longitude: nil, latitude: nil),
        CityLocation(name: "Munich", longitude: nil, latitude: nil),
        CityLocation(name: nil, longitude: nil, latitude: nil)
    ]
    var delegate: SetCitySelection?
    //MARK: UI
    let tableView = UITableView()
    let titleLabel = UILabel()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        //Background gradient - image
        if let gradientImage = UIImage(named: "gradient.png") {
            view.backgroundColor = UIColor(patternImage: gradientImage)
        }else{
            view.backgroundColor = UIColor.white
        }
        setupTableView()
    }
    
    //MARK: METHODS
    func setupTableView() {
        //Background gradient - image
        if let gradientImage = UIImage(named: "gradient.png") {
            tableView.backgroundColor = UIColor(patternImage: gradientImage)
        }else{
            tableView.backgroundColor = UIColor.white
        }
        //tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "What city do you want to consult?"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: Constants.FONT_NORMAL, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}

//MARK: LOGICAL ENTITIES
extension CityListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.layer.backgroundColor = UIColor.clear.cgColor
    cell.textLabel?.textColor = .white
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.text = cities[indexPath.row].name ?? "My current location"
    return cell
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        dismiss(animated: true){
            self.delegate?.selectedcity(city: city)
        }
    }
}
