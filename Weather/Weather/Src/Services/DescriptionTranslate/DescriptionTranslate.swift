//
//  DescriptionTranslate.swift
//  Weather
//
//  Created by Александр Головин on 26.05.2023.
//

import UIKit

enum DescriptionTranslate {
    
    static func translate(key: String) -> String {
        let weatherDescriptions: [String: String] = [
            "clear": "Ясно",
            "partly-cloudy": "Малооблачно",
            "cloudy": "Облачно с прояснениями",
            "overcast": "Пасмурно",
            "partly-cloudy-and-light-rain": "Малооблачно, небольшой дождь",
            "partly-cloudy-and-rain": "Малооблачно, дождь",
            "overcast-and-rain": "Значительная облачность, сильный дождь",
            "overcast-thunderstorms-with-rain": "Сильный дождь с грозой",
            "cloudy-and-light-rain": "Облачно, небольшой дождь",
            "overcast-and-light-rain": "Значительная облачность, небольшой дождь",
            "cloudy-and-rain": "Облачно, дождь",
            "overcast-and-wet-snow": "Дождь со снегом",
            "partly-cloudy-and-light-snow": "Небольшой снег",
            "partly-cloudy-and-snow": "Малооблачно, снег",
            "overcast-and-snow": "Снегопад",
            "cloudy-and-light-snow": "Облачно, небольшой снег",
            "overcast-and-light-snow": "Значительная облачность, небольшой снег",
            "cloudy-and-snow": "Облачно, снег",
            
            "drizzle": "Морось",
            "light-rain": "Небольшой дождь",
            "rain": "Дождь",
            "moderate-rain": "Умеренно сильный дождь",
            "heavy-rain": "Сильный дождь",
            "continuous-heavy-rain": "Длительный сильный дождь",
            "showers": "Ливень",
            "wet-snow": "Дождь со снегом",
            "light-snow": "Небольшой снег",
            "snow": "Снег",
            "snow-showers": "Снегопад",
            "hail": "Град",
            "thunderstorm": "Гроза",
            "thunderstorm-with-rain": "Дождь с грозой",
            "thunderstorm-with-hail": "Гроза с градом"
        ]
        if let weatherDescription = weatherDescriptions[key] {
            return weatherDescription
        } else {
            return "У погоды нет плохой погоды! :)"
        }
    }
    
    static func generateImage(text: String) -> String {
        
        var imageName = ""
        let dic = ["sun" : ["Ясно"],
                   "easyCloud" : ["Малооблачно","Облачно с прояснениями"],
                   "hardCloud" : ["Пасмурно","Облачно, небольшой дождь", "Значительная облачность, небольшой дождь"],
                   "rain" : ["Малооблачно, небольшой дождь", "Малооблачно, дождь","Сильный дождь с грозой", "Облачно, дождь", "Значительная облачность, сильный дождь","Морось","Небольшой дождь","Дождь","Умеренно сильный дождь","Сильный дождь","Длительный сильный дождь","Ливень","Град","Гроза","Дождь с грозой","Гроза с градом"],
                   "snow" : ["Дождь со снегом","Небольшой снег","Малооблачно, снег","Снегопад","Облачно, небольшой снег","Значительная облачность, небольшой снег","Облачно, снег","Снег"]]
        
        dic.forEach { key, value in
            if value.contains(text) {
                imageName = key
            }
        }
        return imageName
    }
}
