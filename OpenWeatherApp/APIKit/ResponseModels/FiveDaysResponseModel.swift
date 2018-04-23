//
//  FiveDaysResponseModel.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/29.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation

struct FiveDaysResponseModel: Unboxable {
    
    private var _list: [WeatherList]
    private var _city: City
    
    var list: [WeatherList] {
        return _list
    }
    
    var citi: City {
        return _city
    }
    
    init(unboxer: Unboxer) throws {
        
        do {
            _list = try unboxer.unbox(key: "list")
            _city = try unboxer.unbox(key: "city")
        } catch {
            throw AppError.unboxFail
        }
    }
}

struct WeatherList: Unboxable {
    var strDate: String
    var weather: [Weather]
    var main: WeatherDetails
    
    var date: Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        guard let date = formatter.date(from: strDate) else {
            fatalError("could not \(strDate) convert to Date type")
        }
        
        return date
    }
    
    var day: String {
        let day = Calendar.current.component(.weekday, from: date)
        return DateFormatter().weekdaySymbols[day-1]
    }
    
    init(unboxer: Unboxer) throws {
        do {
            strDate = try unboxer.unbox(key: "dt_txt")
            weather = try unboxer.unbox(key: "weather")
            main = try unboxer.unbox(key: "main")
        } catch {
            throw AppError.unboxFail
        }
    }
}
