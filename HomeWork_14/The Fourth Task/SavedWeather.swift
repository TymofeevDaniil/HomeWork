
import Foundation
import RealmSwift

class SavedWeather{
    static let shared = SavedWeather()
    private let realm = try! Realm()
    
    func load() -> (String, String, String, Int, Int, String, String, String, String, String, Int, Int, Int, Int, Int)?{
        let savedData = realm.objects(SavedWeatherModel.self)
        guard let object = savedData.first else {return nil}
        print("loaded -- \(object.name)")
        return (object.name, object.descriptionW, object.icon, object.tempMin, object.tempMax, object.day1, object.day2, object.day3, object.day4, object.day5, object.tempDay1, object.tempDay2, object.tempDay3, object.tempDay4, object.tempDay5)
    }
    func save(newData: (String, String, String, Int, Int, String, String, String, String, String, Int, Int, Int, Int, Int)){
        let objects = realm.objects(SavedWeatherModel.self)
        try! realm.write{
            realm.delete(objects)
        }
        let savedWeather = SavedWeatherModel()
        try! realm.write{
            (savedWeather.name, savedWeather.descriptionW, savedWeather.icon, savedWeather.tempMin, savedWeather.tempMax, savedWeather.day1, savedWeather.day2, savedWeather.day3, savedWeather.day4, savedWeather.day5, savedWeather.tempDay1, savedWeather.tempDay2, savedWeather.tempDay3, savedWeather.tempDay4, savedWeather.tempDay5) = newData
            realm.add(savedWeather)
        }
        print("saved ---\(savedWeather.name)")
    }
}
