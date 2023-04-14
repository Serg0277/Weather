//
//  WeatherModel.swift
//  MyWeather
//
//  Created by  Сергей on 26.03.2022.
//
import Foundation

struct WeatherData : Codable { // так как данные мы получаем в формате Json необходимо декодировать мы подписываем наши структуры на Codeble
    var location = Location() //якобы если бы тут стоял массив то можно было переменным не присваивать значения а так нужно присвоить всем =0
    var current = Current() //если данные с сайта приходят в квадратных скобках то это тип массив если в фигурных то струтктура в моем случае все в фигурных ниже для них делаем отельные структуры
    var forecast = Forecast()
    
}

struct Location : Codable{
    var name: String?
    var region: String?
    var lat: Double = 0
    var lon:Double = 0
}

struct Current : Codable{
    var temp_c:Double? //температура
    var feelslike_c:Double? //ощущается как
    var wind_kph:Double? // скорость ветра
    var wind_dir: String? //направление ветра
    var gust_kph:Double? // порывы ветра
    var condition = Condition()
  
}

struct Condition : Codable{
    var text: String? //"Partly cloudy", //описание погоды
    var icon: String? //"//cdn.weatherapi.com/weather/64x64/night/116.png",
    var code: Int = 0 //1003
}


//------------ 5 day --------------

struct Forecast : Codable{
    var forecastday = [Forecastday]()
}

struct Forecastday : Codable{
    var date: String?
    var date_epoch: Int?
   
  //  var astro = Astro()
     var day = Day()
     var hour = [HourId]()
    
}

struct Day : Codable{
    var maxtemp_c: Double = 0
    var mintemp_c: Double = 0
    var avgtemp_c: Double = 0 //средняя температура
    var maxwind_kph: Double = 0 // максимальная скорость ветра
    var totalprecip_mm: Double = 0 //среднне количество осадков
    var totalprecip_in: Double = 0
    var avgvis_km: Double = 0 //средняя видимость
    var condition = Condition()
}

struct Astro : Codable{
    var sunrise: String? //"05:51 AM",
    var sunset: String? //"06:19 PM",
    var moonrise:String? //"02:25 AM",
    var moonset: String? //"09:42 AM",
    var moon_phase: String? //"Last Quarter",
    var moon_illumination: Int?//"42"
}

struct HourId : Codable{
    var time_epoch: Int = 0 // 1648159200,
    var time: String? // "2022-03-25 00:00",
    var temp_c: Double = 0 // 3.0,
    var condition = Condition()
    var wind_kph: Double // 10.8,
    var wind_dir: String //"N",
    var pressure_mb: Double // 1017.0,
    var pressure_in: Double //30.02 давление,
    var precip_mm: Double //0.5,
    var precip_in: Double //0.02 осадки ,
    var gust_kph: Double // 13.3 порувы ветра,
}

/*
,
                        
                        
                       
                       
                       
                        
                        "humidity": 94,
                        "cloud": 100,
                        "feelslike_c": 0.1,
                        "feelslike_f": 32.2,
                        "windchill_c": 0.1,
                        "windchill_f": 32.2,
                        "heatindex_c": 3.0,
                        "heatindex_f": 37.4,
                        "dewpoint_c": 2.1,
                        "dewpoint_f": 35.8,
                        "will_it_rain": 1,
                        "chance_of_rain": 99,
                        "will_it_snow": 0,
                        "chance_of_snow": 0,
                        "vis_km": 7.0,
                        "vis_miles": 4.0,
                        "gust_mph": 8.3,
                        
                        "uv": 1.0
 
}
*/


  

 
