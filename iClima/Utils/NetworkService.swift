//
//  NetworkService.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import Foundation

struct NetworkService {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
