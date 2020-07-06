//
//  WeatherItem.swift
//  iClima
//
//  Created by Santiago Moreno on 6/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation
struct WeatherItem: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
