//
//  Strings.swift
//  Weather
//
//  Created by Александр Головин on 27.05.2023.
//

enum Strings: String {
    case weatherInfoNotAvailable = "Информация о погоде недоступна"
    case checkInternetConnection = "Приложение 'Weather' не подключено к интернету.\nПроверьте интернет соединение."
    case settings = "Настройки"
    case cancel = "Oтмена"
    case changeCity = "Сменить город"
    case weekForecast = "Недельный прогноз"
    case errorTitle = "Oшибка"
}

enum Fonts: String {
    case montserratBold = "Montserrat-Bold"
    case montserratSemiBold = "Montserrat-SemiBold"
    case montserratMedium = "Montserrat-Medium"
}

enum CoreDataEntity: String {
    case name = "Weather"
}

enum NotificationName: String {
    case newCity = "NewCity"
    case forecast = "Forecast"
    case userInfoKey = "weather"
}

enum CellsId: String {
    case searchCell = "searchCell"
    case forecastCell = "forecastCell"
}

enum Images: String {
    case cloud = "cloud.sun"
    case calendar = "calendar"
    case forButton = "forButton"
    case base = "base"
}

enum Colors: String {
    case appBlack = "appBlack"
    case appBlue = "appBlue"
    case appLightBlue = "appLightBlue"
}

enum AccessibilityIdentifier: String {
    case centerTabBatButton = "centerTabBatButton"
}
