//
//  City.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/29.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import Foundation

struct City: Unboxable {
    
    var _name: String
    
    var name: String {
        return _name
    }
    
    init(unboxer: Unboxer) throws {
        _name = try unboxer.unbox(key: "name")
    }
}
