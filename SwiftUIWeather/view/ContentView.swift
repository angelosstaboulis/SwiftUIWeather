//
//  ContentView.swift
//  SwiftUIWeather
//
//  Created by Angelos Staboulis on 7/11/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import CoreLocation
struct ContentView: View {
    @ObservedObject var currentLocation = GetCurrentLocation()
    @ObservedObject var listWeather = WeatherViewModel()
    @State var list:[WeatherModel] = []
    @State var sumTemperature:Double
    @State var sumHumidity:Double
    @State var sumCloudCover:Double
    @State var averageTemperature:Double
    @State var averageHumidity:Double
    @State var averageCloudCover:Double
    var body: some View {
        VStack {
            HStack{
                Text("Ωρα")
                Text("Θερμοκρασία")
                Text("Υγρασία")
                Text("Συννεφιά")

            }
            List(list,id:\.self){item in
                HStack{
                    Text(String(format:"%.0f",item.timer)).padding(25.0)
                    Text(String(format:"%.1f",item.temperature)).padding(25.0)
                    Text(String(format:"%.1f",item.humidity)).padding(25.0)
                    Text(String(format:"%.1f",item.cloudcover)).padding(25.0)
                }.frame(width:900,height:50)
              
            }.onAppear(perform: {
                let coordinates = currentLocation.lastLocation
                initialValuesInView(latitude: coordinates!.coordinate.latitude, longitude: coordinates!.coordinate.longitude)
            })
            HStack{
                Text("M.O").padding(20.0)
                Text(String(format:"%.1f",averageTemperature)).padding(25.0)
                Text(String(format:"%.1f",averageHumidity)).padding(25.0)
                Text(String(format:"%.1f",averageCloudCover)).padding(25.0)

            }
        }
        .padding()

    }
    func initialValuesInView(latitude:Double,longitude:Double){
        Task.init{
            list.append(contentsOf: await listWeather.fetchWeatherResponse(latitude: latitude, longitutde: longitude))
            for item in 0..<list.count{
                sumTemperature = sumTemperature + list[item].temperature
                sumHumidity = sumHumidity + list[item].humidity
                sumCloudCover = sumCloudCover + list[item].cloudcover
            }
            averageTemperature = sumTemperature / Double(list.count)
            averageHumidity = sumHumidity / Double(list.count)
            averageCloudCover = sumCloudCover / Double(list.count)
        }
    }
}

#Preview {
    ContentView(sumTemperature: 0.0, sumHumidity: 0.0, sumCloudCover: 0.0, averageTemperature: 0.0, averageHumidity: 0.0, averageCloudCover: 0.0)
}
