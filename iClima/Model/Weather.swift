//
//  Weather.swift
//  iClima
//
//  Created by Santiago Moreno on 6/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation
struct Weather: Codable {
    var base: String
    var dt: Double
    var timezone: Double
    var id: Double
    var name: String
    var cod: Int
    var main: Main
    var wind: Wind
    var weather: Array<WeatherItem>
}
