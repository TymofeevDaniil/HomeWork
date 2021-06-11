
import Foundation
import RealmSwift

class SavedWeather{
    static let shared = SavedWeather()
    private let realm = try! Realm()
    
    func load() -> (String, String, String, Int, Int, String, String, String, String, String, Int, Int, Int, Int, Int)?{
        let savedData = realm.objects(SavedWeatherModel.self)
        guard let object = savedData.first else {return nil}
        print("loaded")
        return (object.name, object.descriptionW, object.icon, object.tempMin, object.tempMax, object.day1, object.day2, object.day3, object.day4, object.day5, object.tempDay1, object.tempDay2, object.tempDay3, object.tempDay4, object.tempDay5)
    }
    func save(newData: (String, String, String, Int, Int, String, String, String, String, String, Int, Int, Int, Int, Int)){
        let savedWeather = realm.objects(SavedWeatherModel.self)
        guard let data = savedWeather.first else {return}
        try! realm.write{
            (data.name, data.descriptionW, data.icon, data.tempMin, data.tempMax, data.day1, data.day2, data.day3, data.day4, data.day5, data.tempDay1, data.tempDay2, data.tempDay3, data.tempDay4, data.tempDay5) = newData
        }
        print("saved")
    }
}
