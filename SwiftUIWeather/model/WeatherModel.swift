//
//  WeatherModel.swift
//  SwiftUIWeather
//
//  Created by Angelos Staboulis on 8/11/23.
//

import Foundation
struct ID<T>:Equatable{
    private let id = UUID()
}
struct WeatherModel:Hashable{
    func hash(into hasher: inout Hasher) {}
    let id = ID<Self>()
    let timer:Double
    let temperature:Double
    let humidity:Double
    let cloudcover:Double
}
