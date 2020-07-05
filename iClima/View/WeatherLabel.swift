//
//  WeatherLabel.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import UIKit

class WeatherLabel: UILabel {
    private var _temperature: Double?
    
    var temperature: Double? {
        get{
            return _temperature
        }
        set {
            _temperature = newValue
            let celciusValue = Formatter.kelvinToCelcius(temp: newValue ?? 0)
            let celciusString = Formatter.formatCelcius(temp: celciusValue)
            self.text = celciusString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "- °C"
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: Constants.FONT_EXTRALARGE, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
