//
//  WeatherItemView.swift
//  iClima
//
//  Created by Santiago Moreno on 5/07/20.
//  Copyright © 2020 Santiago Moreno. All rights reserved.
//

import UIKit

class StackItemView: UIView {
    
    private var _maxTemp: Double?
    private var _minTemp: Double?
    private var _wind: Double?
    private var maxTempValue: UILabel = UILabel()
    private var minTempValue: UILabel = UILabel()
    private var windValue: UILabel = UILabel()
    
    var maxTemp: Double? {
        get{
            return _maxTemp
        }
        set {
            _maxTemp = newValue
            let celciusValue = Formatter.kelvinToCelcius(temp: newValue ?? 0)
            let celciusString = Formatter.formatCelcius(temp: celciusValue)
            maxTempValue.text = celciusString
        }
    }
    
    var minTemp: Double? {
        get{
            return _minTemp
        }
        set {
            _minTemp = newValue
            let celciusValue = Formatter.kelvinToCelcius(temp: newValue ?? 0)
            let celciusString = Formatter.formatCelcius(temp: celciusValue)
            minTempValue.text = celciusString
        }
    }
    
    var wind: Double? {
        get{
            return _wind
        }
        set {
            _wind = newValue
            windValue.text = String(format: "%.1f", newValue ?? 0)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Create the images
        let maxTempIcon = UIImage(named: "max_temp.png")
        let minTempIcon = UIImage(named: "min_temp.png")
        let windIcon = UIImage(named: "wind.png")
        
        let maxTempIconImage = UIImageView(image: maxTempIcon)
        let minTempIconImage = UIImageView(image: minTempIcon)
        let windImage = UIImageView(image: windIcon)
        
        //Create the labels for the values
        maxTempValue = UILabel()
        maxTempValue.text = "- °C"
        maxTempValue.textAlignment = .center
        maxTempValue.textColor = UIColor.white
        maxTempValue.font = UIFont.systemFont(ofSize: Constants.FONT_NORMAL, weight: .bold)
        
        minTempValue = UILabel()
        minTempValue.text = "- °C"
        minTempValue.textAlignment = .center
        minTempValue.textColor = UIColor.white
        minTempValue.font = UIFont.systemFont(ofSize: Constants.FONT_NORMAL, weight: .bold)
        
        windValue = UILabel()
        windValue.text = "0.0"
        windValue.textAlignment = .center
        windValue.textColor = UIColor.white
        windValue.font = UIFont.systemFont(ofSize: Constants.FONT_NORMAL, weight: .bold)
        
        //Create the labels
        let maxLabel = UILabel()
        maxLabel.text = "Max"
        maxLabel.textAlignment = .center
        maxLabel.textColor = UIColor.white
        maxLabel.font = UIFont(name: maxLabel.font.fontName, size: Constants.FONT_SMALL)
        
        let minLabel = UILabel()
        minLabel.text = "Min"
        minLabel.textAlignment = .center
        minLabel.textColor = UIColor.white
        minLabel.font = UIFont(name: minLabel.font.fontName, size: Constants.FONT_SMALL)
        
        let windLabel = UILabel()
        windLabel.text = "Wind"
        windLabel.textAlignment = .center
        windLabel.textColor = UIColor.white
        windLabel.font = UIFont(name: windLabel.font.fontName, size: Constants.FONT_SMALL)
        
        //Create the inner stack views
        let maxStackView = UIStackView()
        maxStackView.addArrangedSubview(maxTempIconImage)
        maxStackView.addArrangedSubview(maxTempValue)
        maxStackView.addArrangedSubview(maxLabel)
        maxStackView.axis = .vertical;
        maxStackView.distribution = .equalSpacing;
        maxStackView.alignment = .center;
        maxStackView.spacing = Constants.SPACING_SMALL;
        
        let minStackView = UIStackView()
        minStackView.addArrangedSubview(minTempIconImage)
        minStackView.addArrangedSubview(minTempValue)
        minStackView.addArrangedSubview(minLabel)
        minStackView.axis = .vertical;
        minStackView.distribution = .equalSpacing;
        minStackView.alignment = .center;
        minStackView.spacing = Constants.SPACING_SMALL;
        
        let windStackView = UIStackView()
        windStackView.addArrangedSubview(windImage)
        windStackView.addArrangedSubview(windValue)
        windStackView.addArrangedSubview(windLabel)
        windStackView.axis = .vertical;
        windStackView.distribution = .equalSpacing;
        windStackView.alignment = .center;
        windStackView.spacing = Constants.SPACING_SMALL;
        
        //Create the main stackview
        let itemsStackView = UIStackView()
        itemsStackView.addArrangedSubview(maxStackView)
        itemsStackView.addArrangedSubview(minStackView)
        itemsStackView.addArrangedSubview(windStackView)
        
        itemsStackView.axis = .horizontal;
        itemsStackView.distribution = .equalSpacing;
        itemsStackView.alignment = .center;
        itemsStackView.spacing = 30;
        
        itemsStackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.addSubview(itemsStackView)
        
        itemsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        itemsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
