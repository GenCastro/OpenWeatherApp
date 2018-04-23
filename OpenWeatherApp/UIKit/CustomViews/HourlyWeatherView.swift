//
//  HourlyWeatherView.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/30.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import UIKit

class HourlyWeatherView: UIView {

    var timeLabel = UILabel()
    var tempLabel = UILabel()
    var weatherDescriptionLabel = UILabel()
    var labelsStack = UIStackView()

    init(weather: WeatherList) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = DateFormatter().string(from: weather.date)
        tempLabel.text = "\(weather.main.temp)"
        weatherDescriptionLabel.text = weather.weather.flatMap({$0.description}).joined(separator: " and ")
        
        labelsStack.axis = .vertical
        labelsStack.distribution = .fill
        labelsStack.alignment = .leading
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(labelsStack)
        labelsStack.addArrangedSubview(timeLabel)
        labelsStack.addArrangedSubview(tempLabel)
        labelsStack.addArrangedSubview(weatherDescriptionLabel)
        addStackConstraints()
    }
    
    func addStackConstraints() {
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackview]|", options: [], metrics: nil, views: ["stackview": labelsStack]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stackview]-|", options: [], metrics: nil, views: ["stackview": labelsStack]))
    }
}
