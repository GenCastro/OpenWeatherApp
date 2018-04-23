//
//  WeatherDetails.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/29.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation

struct WeatherDetails: Unboxable {
    var temp: Float
    
    init(unboxer: Unboxer) throws {
        
        do {
            temp = try unboxer.unbox(key: "temp")
        } catch {
            throw AppError.unboxFail
        }
        
    }
}
