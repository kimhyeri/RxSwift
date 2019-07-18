//
//  WeatherResult.swift
//  Errors
//
//  Created by hyeri kim on 18/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult{
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0, humidity: 0))
    }
}
