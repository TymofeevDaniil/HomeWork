
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
    
}
