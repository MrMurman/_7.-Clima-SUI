//
//  ContentView.swift
//  _7. Clima-SUI
//
//  Created by Андрей Бородкин on 16.02.2023.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct ContentView: View {
   
    
    @State var searchLocation: String = ""
 
    @ObservedObject var weatherManager = WeatherManager()
    
    @StateObject var viewModel = ContentViewModel()

      
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(width: geo.size.width, height: geo.size.height)
                
                VStack {
                    
                    
                    HStack {
                        
                        LocationButton(.currentLocation) {
                            viewModel.requestAllowOnceLocationPermission()
                        }
                                .font(.system(size: 30))
                                .foregroundColor(.primary)
                                .labelStyle(.iconOnly)
                                .tint(.clear)
                        
                        TextField("Search", text: $searchLocation, onCommit: {
                            // some code
                            // find a way to disable pushing return button, unless there is text in textfield
                            
                           updateWeatherInfo()
                        })
                            .multilineTextAlignment(.trailing)
                            .padding(8)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .opacity(0.7)
                            .foregroundColor(.primary)
                            
                        
                        Button {
                           updateWeatherInfo()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 30))
                                .foregroundColor(.primary)
                        }
                        
                    }
                    
                    HStack {
                        
                        Spacer()
                        Image(systemName: weatherManager.fetchedWeather.conditionName)
                            .font(.system(size: 100))
                    }
                    
                    
                    HStack {
                        Spacer()
                        HStack{
                            Text(weatherManager.fetchedWeather.temperatureString)
                                .foregroundColor(.primary)
                                .font(.system(size: 80, weight: .bold, design: .rounded))
                            Text("°C")
                                .foregroundColor(.primary)
                                .font(.system(size: 80, weight: .light, design: .rounded))
                        }
                    }
                    
                    
                    HStack{
                        
                        Spacer()
                        Text(weatherManager.fetchedWeather.cityName)
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding()
                
            }
            
        }
    }
    
    func updateWeatherInfo() {
        weatherManager.fetchWeather(cityName: searchLocation)
        if let error = weatherManager.error {
            print(error)
        }
        searchLocation = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
     
    let locationManager = CLLocationManager()
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}
        
        DispatchQueue.main.async {
            
            print("got location")
            print(latestLocation)
        }
    }
     
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
