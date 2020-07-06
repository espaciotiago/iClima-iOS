//
//  CityLocation.swift
//  iClima
//
//  Created by Santiago Moreno on 6/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation

struct CityLocation {
    private var _name: String?
    private var _longitude: Double?
    private var _latitude: Double?
    
    var name: String? {
        get {
            return _name
        }set{
            _name = newValue
        }
    }
    
    var longitude: Double? {
        get {
            return _longitude
        }set{
            _longitude = newValue
        }
    }
    
    var latitude: Double? {
        get {
            return _latitude
        }set{
            _latitude = newValue
        }
    }
    
    init(name: String?, longitude: Double?, latitude: Double?) {
        self._name = name
        self._longitude = longitude
        self._latitude = latitude
    }
}
