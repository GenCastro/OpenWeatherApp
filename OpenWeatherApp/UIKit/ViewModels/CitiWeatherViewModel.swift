//
//  CitiWeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/28.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation
import RxSwift

class CitiWeatherViewModel {
    
    private var disposeBag = DisposeBag()
    
    var weatherArrangedByDate = Variable<[[WeatherList]]>([])
    
    init() {
        getWeather()
    }
    
    func getWeather() {
        
        let _ = WeatherServices().getCitiWeather(citi: "993800")
        .subscribe(onNext: { (weatherData) in
            
            let list = weatherData.list.flatMap{$0}
            
            let days: [String] = list.flatMap({ (data) -> String? in
                return data.day
            })
            
            let set = Set(days)
            
            var filterList: [[WeatherList]] = []
            set.forEach({ (day) in
                filterList.append(list.filter{$0.day == day})
            })
            
            let sortedList = filterList.sorted(by: {$0[0].date < $1[0].date})
            
            self.weatherArrangedByDate.value = sortedList
            
        }, onError: { (error) in
            print("***Error:", error.localizedDescription)
        })
        .disposed(by: disposeBag)
    }
}
