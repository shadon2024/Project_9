//
//  WeatherData.swift
//  weather_Api
//
//  Created by Admin on 28/05/24.
//

import Foundation

// MARK: - Weather
struct WeatherData: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let hourlyUnits: HourlyUnits
    let hourly: Hourly

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]
    let temperature2M: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    let time, temperature2M: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
    }
}
