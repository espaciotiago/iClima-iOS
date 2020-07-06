//
//  ConfigurationManager.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation

struct ConfigurationManager {
    static func getWeatherApiKey() -> String {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            return ""
        }
        guard let consfigurationDictionary = NSDictionary(contentsOfFile: path) else {
            return ""
        }
        return consfigurationDictionary[Constants.WEATHER_KEY] as? String ?? ""
    }
    static func getMainUrl() -> String {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            return ""
        }
        guard let consfigurationDictionary = NSDictionary(contentsOfFile: path) else {
            return ""
        }
        return consfigurationDictionary[Constants.MAIN_URL_KEY] as? String ?? ""
    }
    static func getImageUrl() -> String {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            return ""
        }
        guard let consfigurationDictionary = NSDictionary(contentsOfFile: path) else {
            return ""
        }
        return consfigurationDictionary[Constants.WEATHER_IMAGE_URL] as? String ?? ""
    }
    static func getImageExtension() -> String {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            return ""
        }
        guard let consfigurationDictionary = NSDictionary(contentsOfFile: path) else {
            return ""
        }
        return consfigurationDictionary[Constants.WEATHER_IMAGE_EXTENSION] as? String ?? ""
    }
}
