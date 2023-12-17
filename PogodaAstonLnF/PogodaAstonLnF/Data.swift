////
////  Data.swift
////  PogodaAstonLnF
////
////  Created by Калякин Дима  on 07.12.2023.
////
//
//import Foundation
struct Weather: Codable{
    var id: Int
    var main: String
    var description: String
    var icon: String
}


struct Main: Codable{
    var temp: Double = 0.0
    var humodity: Int = 0
    var presuare: Int = 0 
    
}

 
struct WeatherData: Codable{
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = ""
}
