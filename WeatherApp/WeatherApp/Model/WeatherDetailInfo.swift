//
//  WeatherDetailInfo.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
public struct WeatherDetailInfo : Codable {
    public var id: Int
    public var condition: String
    public var description: String
    public var icon: String

    private enum CodingKeys: String, CodingKey {
        case id
        case condition = "main"
        case description
        case icon
    }
}
