//
//  SwiftUIWeatherApp.swift
//  SwiftUIWeather
//
//  Created by Angelos Staboulis on 7/11/23.
//

import SwiftUI

@main
struct SwiftUIWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(sumTemperature: 0.0, sumHumidity: 0.0, sumCloudCover: 0.0, averageTemperature: 0.0, averageHumidity: 0.0, averageCloudCover: 0.0)

        }
    }
}
