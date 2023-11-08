//
//  GetCurrentLocation.swift
//  SwiftUIWeather
//
//  Created by Angelos Staboulis on 7/11/23.
//

import Foundation
import CoreLocation
import Combine
class GetCurrentLocation:NSObject,ObservableObject,CLLocationManagerDelegate{
    private var location = CLLocationManager ()
    let objectWillChange = PassthroughSubject<Void,Never>()

    @Published var lastLocation:CLLocation!{
        willSet{
            objectWillChange.send()
        }
    }
    override init() {
        super.init()
        self.location.delegate = self
        self.location.requestWhenInUseAuthorization()
        self.location.startUpdatingLocation()
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.first
    }
    
}
