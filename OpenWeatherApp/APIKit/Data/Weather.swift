//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/29.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation

struct Weather: Unboxable {
    var description: String
    
    init(unboxer: Unboxer) throws {
        
        do {
            description = try unboxer.unbox(key: "description")
        } catch {
            throw AppError.unboxFail
        }
        
    }
}
