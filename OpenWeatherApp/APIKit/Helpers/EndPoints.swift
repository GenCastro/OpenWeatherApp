//
//  EndPoints.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/28.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation

struct EndPoints {
    private static let baseUrl = "https://api.openweathermap.org/data/2.5"
    
    struct Weather {
        private static let route = "/forecast"
        static let cityForecast = URL(string: "\(baseUrl)\(route)")
    }
}
