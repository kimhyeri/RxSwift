//
//  Extension+URL.swift
//  Errors
//
//  Created by hyeri kim on 18/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22")
    }
}
