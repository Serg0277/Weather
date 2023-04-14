//
//  Weather.swift
//  MyWeather
//
//  Created by  Сергей on 20.03.2022.
//

import Foundation

struct WeatherData:Codable { // так как данные мы получаем в формате Json и хи необходимо декодировать мы подписываем наши структуры на Codeble
    var location = Location() //якобы если бы тут стоял массив то можно бвло переменным не присваивать значения а так нужно присвоить всем =0
    var current = Current () //если данные с сайта приходят в квадратных скобках то это тип массив если в фигурных то струтктура в моем случае все в фигурных ниже для них делаем отельные структуры
}

struct Location : Codable{
    var name: String?
    var region: String?
    var lat: Double = 0
    var lon:Double = 0
    /*
    "name": "Moskau",
            "region": "Moscow City",
            "country": "Russia",
            "lat": 55.75,
            "lon": 37.62,
            "tz_id": "Europe/Moscow",
            "localtime_epoch": 1646496448,
            "localtime": "2022-03-05 19:07"
*/
}

struct Current : Codable{
    //var condition:String?
                
    var temp_c:Double?
    var wind_kph:Double?
    var gust_kph:Double? // порывы ветра
    var condition: Condition = Condition()
}
struct Condition : Codable{
    var text: String? //"Partly cloudy", //описание погоды
    var icon: String? //"//cdn.weatherapi.com/weather/64x64/night/116.png",
    var code: Int = 0 //1003
    
} /*
     "last_updated_epoch": 1646492400,
            "last_updated": "2022-03-05 18:00",
            "temp_c": -2.0,
            "temp_f": 28.4,
            "is_day": 0,
            "condition": {
                "text": "Partly cloudy", //описание погоды
                "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png",
                "code": 1003
            },
            "wind_mph": 13.6,
            "wind_kph": 22.0,
            "wind_degree": 330,
            "wind_dir": "NNW",
            "pressure_mb": 1017.0,
            "pressure_in": 30.03,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "humidity": 69,
            "cloud": 75,
            "feelslike_c": -7.2,
            "feelslike_f": 19.1,
            "vis_km": 10.0,
            "vis_miles": 6.0,
            "uv": 1.0,
            "gust_mph": 14.8, //порывы ветра
            "gust_kph": 23.8
     */

