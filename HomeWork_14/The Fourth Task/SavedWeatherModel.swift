
import Foundation
import RealmSwift

class SavedWeatherModel: Object{
    @objc dynamic var name = String()
    @objc dynamic var descriptionW = String()
    @objc dynamic var icon = String()
    @objc dynamic var tempMin = Int()
    @objc dynamic var tempMax = Int()
    
    @objc dynamic var day1 = String()
    @objc dynamic var day2 = String()
    @objc dynamic var day3 = String()
    @objc dynamic var day4 = String()
    @objc dynamic var day5 = String()
    
    @objc dynamic var tempDay1 = Int()
    @objc dynamic var tempDay2 = Int()
    @objc dynamic var tempDay3 = Int()
    @objc dynamic var tempDay4 = Int()
    @objc dynamic var tempDay5 = Int()
    
//    func data() -> (String, String, String, Int, Int, String, String, String, String, String, Int, Int, Int, Int, Int){
//        return (name, descriptionW, icon, tempMin, tempMax, day1, day2, day3, day4, day5, tempDay1, tempDay2, tempDay3, tempDay4, tempDay5)
//    }
}
