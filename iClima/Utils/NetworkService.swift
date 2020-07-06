//
//  NetworkService.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkService {
    
    let apiKey = ConfigurationManager.getWeatherApiKey()
    let baseUrl = ConfigurationManager.getMainUrl()
    
    func getImageFromUrl(from icon: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        if let url = URL(string: getImageUrl(icon: icon)) {
            getData(from: url, completion: completion)
        }
    }
    
    func getWeatherData(of city: CityLocation?, completion: @escaping (Weather?, Bool,String?) -> ()){
        if let city = city {
            if let name = city.name {
                let realName = name.replacingOccurrences(of: " ", with: "%20")
                let url = "\(baseUrl)/weather?q=\(realName)&appid=\(apiKey)"
                //Get info by name
                performGet(url: url, completion: completion)
            }else if let longitude = city.longitude, let latitude = city.latitude {
                //Get info by lat long
                let url = "\(baseUrl)/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
                performGet(url: url, completion: completion)
            }else{
                completion(nil, false, "City selection error: No params for query")
            }
        }else{
            completion(nil, false, "An error has occured")
        }
    }
    
    func performGet(url: String, completion: @escaping (Weather?, Bool, String?) -> ()){
        AF.request(url,requestModifier: { $0.timeoutInterval = 5 }).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if(statusCode >= 200 && statusCode < 300){
                    if let data = response.data {
                        do{
                            let decoder = JSONDecoder()
                            let weather = try decoder.decode(Weather.self, from: data)
                            completion(weather, true, nil)
                        }catch {
                            completion(nil, false, "Failed decoding the object")
                        }
                    }else{
                        completion(nil, false,"No data")
                    }
                }else{
                    completion(nil, false,"Error with status: \(statusCode)")
                }
            }else{
                completion(nil, false, "Error on the request response, no status code")
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getImageUrl(icon: String)->String{
        return "\(ConfigurationManager.getImageUrl())/\(icon)\(ConfigurationManager.getImageExtension())"
    }
}
