//
//  Formatter.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation

struct Formatter {
    static func formatCelcius(temp: Double) -> String {
        let formatted = String(format: "%.1f", temp)
        return "\(formatted) °C"
    }
    static func kelvinToCelcius(temp: Double) -> Double {
        return temp - 273.15
    }
}
