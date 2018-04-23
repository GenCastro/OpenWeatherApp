//
//  WeatherServices.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/28.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation
import RxSwift

struct WeatherServices {
    
    func getCitiWeather(citi id: String) -> Observable<FiveDaysResponseModel> {
        
        guard let url = EndPoints.Weather.cityForecast else {
            fatalError("Unable to load citi URL")
        }
        
        let request = RequestModel(url: url, parameters: ["id": id])
        
        return ApiClient().performRequest(request: request).map { results in
            
            switch results {
            case .success(let jsonData):
                do {
                    let fiveDaysData: FiveDaysResponseModel = try unbox(dictionary: jsonData)
                    return fiveDaysData
                    
                } catch(let error) {
                    throw error
                }
                
            case .failure(let error):
                throw error
            }
        }
    }
}
