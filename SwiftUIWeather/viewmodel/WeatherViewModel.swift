//
//  WeatherViewModel.swift
//  SwiftUIWeather
//
//  Created by Angelos Staboulis on 8/11/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class WeatherViewModel:ObservableObject{
    func fillFieldsWithValues(dict:[String:JSON])->(JSON,JSON,JSON,JSON){
        let timer = dict["hourly"]!["time"]
        let temperature = dict["hourly"]!["temperature_2m"]
        let humidity = dict["hourly"]!["relative_humidity_2m"]
        let cloudcover = dict["hourly"]!["cloud_cover"]
        return (timer,temperature,humidity,cloudcover)
    }
    func fetchWeatherResponse(latitude:Double,longitutde:Double) async ->  [WeatherModel]{
        return await withCheckedContinuation { checked in
            let API_URL = "https://api.open-meteo.com/v1/forecast?latitude="+String(describing:latitude)+"&longitude="+String(describing:longitutde)+"&hourly=temperature_2m,relative_humidity_2m,cloud_cover&forecast_days=1"
                        let weatherURL = URL(string: API_URL)
                        let request = URLRequest(url: weatherURL!)
                        AF.request(request).response { dataResponse in
                            do{
                                let json = try JSON(data: dataResponse.data!)
                                let dict = json.dictionary
                                let timer = self.fillFieldsWithValues(dict: dict!).0
                                let temperature = self.fillFieldsWithValues(dict: dict!).1
                                let humidity = self.fillFieldsWithValues(dict: dict!).2
                                let cloudcover = self.fillFieldsWithValues(dict: dict!).3
                                var weatherArray:[WeatherModel] = []
                                var hourTable:String.SubSequence!
                                var newIndex:Int!=0
                                newIndex = timer[0].stringValue.lastIndex(of: "T")!.utf16Offset(in: timer[0].stringValue) - 1
                                hourTable = String(timer[0].stringValue.dropFirst(newIndex+2)).dropLast(3)
                                for item in 0..<timer.count-1 where Int(hourTable)! % 4 == 0 && item%4 == 0 {
                                    newIndex = timer[item].stringValue.lastIndex(of: "T")!.utf16Offset(in: timer[item].stringValue) - 1
                                    hourTable = String(timer[item].stringValue.dropFirst(newIndex+2)).dropLast(3)
                                    let model = WeatherModel(timer: Double(Int(hourTable)!), temperature: temperature[item].doubleValue, humidity: humidity[item].doubleValue, cloudcover: cloudcover[item].doubleValue)
                                    weatherArray.append(model)
                                }
                                checked.resume(returning: weatherArray)
                               
                            }catch{
                                debugPrint("something went wrong!!!")
                            }
                    }
           
        }

    }
}
