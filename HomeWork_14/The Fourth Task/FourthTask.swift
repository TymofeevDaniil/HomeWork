import UIKit
import RealmSwift

class FourthTask: UIViewController {
    var name = "Loading"
    var descriptionW = "Loading"
    var icon = "11d"
    var tempMin = 00
    var tempMax = 00
    var day1 = "Loading"
    var day2 = "Loading"
    var day3 = "Loading"
    var day4 = "Loading"
    var day5 = "Loading"
    var tempDay1 = 00
    var tempDay2 = 00
    var tempDay3 = 00
    var tempDay4 = 00
    var tempDay5 = 00
    let c = "C\u{00B0}" // "C" and celsius symbol
    var cityID = ""
    
    @IBOutlet weak var countryNameTextField: UITextField!
    @IBAction func goButton(_ sender: Any) {
        cityUrl()
        WeatherDataLoader().cityDataLoader(url: cityID){ weather in
            print(weather.name)
            SavedWeather.shared.save(newData: weather.getData())
            print(weather.name)
            self.updateData()
            self.updateView()
        }
    }
    
    func cityUrl() {
        guard let city = countryNameTextField.text else {return cityID = "https://api.openweathermap.org/data/2.5/forecast?q=\(name)&units=metric&appid=7b92543413e935f9b9ae8273cb2f54d2&lang=RU"
        }
        cityID = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&appid=7b92543413e935f9b9ae8273cb2f54d2&lang=RU"
    }
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        updateData()
        updateView()
        WeatherDataLoader().cityDataLoader(url: cityID){ weather in
            print(weather.name)
            SavedWeather.shared.save(newData: weather.getData())
            print(weather.name)
            self.updateData()
            self.updateView()
            print("data saved in Realm")
        }
    }
    func updateData(){
        guard let objects = SavedWeather.shared.load() else {
            WeatherDataLoader().loadWeatherAlamofire{ weather in
                print(weather.name)
                SavedWeather.shared.save(newData: weather.getData())
                print(weather.name)
                self.updateData()
                self.updateView()
            }
            return}
        (self.name, self.descriptionW, self.icon, self.tempMin, self.tempMax, self.day1, self.day2, self.day3, self.day4, self.day5, self.tempDay1, self.tempDay2, self.tempDay3, self.tempDay4, self.tempDay5) = objects
        print("data loaded from Realm")
    }
    func updateView(){
        self.cityNameLabel.text = name
        self.mainTempLabel.text = "\(tempDay1) \(c)"
        self.minTempLabel.text = "мин.  \(tempMin) \(c)"
        self.maxTempLabel.text = "макс. \(tempMax) \(c)"
        self.iconImageView.image = UIImage(named: icon)
        self.descriptionLabel.text = descriptionW
        listTable.reloadData()
        view.layoutIfNeeded()
        view.layoutSubviews()
        print("view updated")
    }
}
extension FourthTask: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fiveDayCell") as! fiveDayCell
        let dayList = [day1, day2, day3, day4, day5]
        let tempList = [tempDay1, tempDay2, tempDay3, tempDay4, tempDay5]
        cell.dateLabel.text = dayList[indexPath.row]
        cell.tempLabel.text = String(tempList[indexPath.row]) + " \(self.c)"
        return cell
    }
}

