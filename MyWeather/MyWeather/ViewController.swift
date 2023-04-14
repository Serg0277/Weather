//
//  ViewController.swift
//  MyWeather
//
//  Created by  Сергей on 19.03.2022.
//
//Location: CoreLocation
//custom cell: collection view
//API / request to get the data
// не забываем про настройки доступа приложения к координатам -> Privacy - Location When In Use Usage Description
// тут по другому выбираем симулятор и в  верхнем меню быбираем features -> location - > apple


//Privacy - Location When In Use Usage Description -это разрешение на определение местоположения  в инфо добовляем
//--- и в настройках проекта там где иконка проекта жмем левой клавишей и выбираем Edit Shemi... в поле Defolt Location вместо None любой город это для тестирования
// если программа не загружает с сайта информацию необходимо в настройках проекта добавить разрешить обращатся к интеренту то в info добавляем App Transport Security Settings  и добавляем Allow Arbitrary Loads ставим YES



//Location: CoreLocation
//custom cell: collection view
//API / request to get the data
import UIKit
import CoreLocation
 
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    //создаем аутлеты table это обязательно не забываем
    @IBOutlet var table: UITableView!
    let dayId = DayId()
    var weatherArray = [Forecastday]()
    var weatherData = WeatherData()
    let locationManager = CLLocationManager()
    var lastCoordinate: CLLocation?
    var iconId = IconID()
    var windId = WindId()
    //два раза выполняется функция таблиц отдельно сделал переменную
    var countCell: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //Register 2 Cell создаем кастомные ячейки и регистрируем их в table
        
      
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)

       table.delegate = self // стандартная херня при подключении таблицы - делигат и датасорс, а можно в сториборд все это сделать
       table.dataSource = self
        
        table.backgroundColor = UIColor(red: 32/255.0, green: 178/255.0, blue: 170/255.0, alpha: 1.0 )
        view.backgroundColor = UIColor(red: 32/255.0, green: 178/255.0, blue: 170/255.0, alpha: 1.0 )
    }
    
    // мне кажетс тут все зарвто запрос локации сюда нужно иначе таблица бысрее загружается
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
       
    }
    
    
    //Location
    func setupLocation(){
        //снаачла запрос на авторизацию можно ли нам получать данные
        locationManager.requestWhenInUseAuthorization() // два типа первый когда приложение свернуто (батарею жрет) второй мы используем и сейчас
        //проверка вообще рабтает ли сервис геолокации в телефоне
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self //при изменении местоположения запрос новый срабатывает (подписывемся на делегате)
            //устанавливаем точность позиционирования 100 меторов
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            //может автоматически отключается если мы не перемещаемся тут не столь важно просто знать
            locationManager.pausesLocationUpdatesAutomatically = false
            // после этого запкскается слежение за нашим местом положения
            locationManager.startUpdatingLocation()
        }
    }
    //  2 стандартный  метод получения  координат это и есть делегат (я до этого делал через extension)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       //проверка получали ли мы кординаты
     //if locations.isEmpty, lastCoordinate == nil{
            // last and first надо еще разобраться когда что использовать
            
        lastCoordinate = locations.last
        locationManager.stopUpdatingLocation()
        requestWeatherForLocation()
      //  }
    }
    // 3 функция получения данных по координтам
    func requestWeatherForLocation(){
       
        // потом надо будет это все в гуард взять , coordinate не удачно взял переменную(((
        let long = lastCoordinate?.coordinate.longitude
        let lat = lastCoordinate?.coordinate.latitude
        let url = URL(string:"https://api.weatherapi.com/v1/forecast.json?key=8a2e4792a0434648b6974213220403&q=\(lat!.description),\(long!.description)&days=3&aqi=no&alerts=no&lang=ru")!
   
        let session = URLSession.shared
        //это было уже в предыдущем уроке но ранне делали проще
        //обращаемся к сайту (замыкание когда придет ответ с сайта)
        // в замыкании data - данные непосредственно поля, responce - заголовки ответа от сайта, error - ошибка
        let task = session.dataTask(with: url) { [self](data, responce, error) in
            //проверка на ошибку получени данных
            guard error  == nil else {
                print("Data task error!\(error!.localizedDescription)")
                return
            }
           
            
            do{   // так как данные с сервера приходят в формате Json или как тот так мы сосзаем отдельно структуру где это все опишем чтоб тут не городить
                var jsoon : WeatherData?
                jsoon = try JSONDecoder().decode(WeatherData.self, from: data!)
                weatherData = jsoon!
                    
                
                
                let entries  = jsoon?.forecast.forecastday
              //  print(weatherArray.count)
                self.weatherArray.removeAll()
                self.weatherArray.append(contentsOf: (entries!))
              //  print(weatherArray.count)
               
            //обновление экра и запрос на сайт происходит в разных потоках поэтому для взаимодействия используют этот метод просто запомнить пока
                DispatchQueue.main.async { //это основной поток так переключаемся на основной поток иначе приложение загрузится а картинка позже мы ее не увидем (отдельно надо изучить)
                    
                   
                    self.table.reloadData()
                    // tableHeaderView расширение верхней строки есть еще нижнестроки что то новое
                    self.table.tableHeaderView = self.creatTableHeader()
                    
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
      // так как выше мы описывали замыкание необходимо запустить его (хотя там везед return используем в замыканиях)*/
    }

    func creatTableHeader () -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2))
        headerView.backgroundColor = UIColor(red: 32/255.0, green: 178/255.0, blue: 170/255.0, alpha: 1.0 )
        
        let locationLable = UILabel(frame: CGRect(x: 10, y: 5, width: view.frame.size.width - 20, height: view.frame.size.height/5))
        
        let iconLable = UIImageView(frame: CGRect(x:200, y: 100, width: 150, height: 150))
       
        let tempLable = UILabel(frame: CGRect(x: 10, y: 30, width: view.frame.size.width - 20, height: view.frame.size.height/2))
        
        
        let windLable = UILabel(frame: CGRect(x: 10, y: tempLable.frame.minY + 40, width: view.frame.size.width - 20, height: view.frame.size.height/2))
        
        let wind_dirLable = UILabel(frame: CGRect(x: view.frame.size.width/2, y: tempLable.frame.minY + 40, width: view.frame.size.width - 20, height: view.frame.size.height/2))
        
       
        headerView.addSubview(iconLable)
        headerView.addSubview(tempLable)
        headerView.addSubview(windLable)
        headerView.addSubview(wind_dirLable)
        headerView.addSubview(locationLable)
        
        iconLable.image = UIImage(named: String(iconId.iconArray[weatherData.current.condition.code]!))
        tempLable.text = String(format: "%.0f", (weatherData.current.temp_c!)) + " °C"
        tempLable.font = UIFont(name: "georgia", size: 32)
        windLable.text = String(format: "%.0f", (weatherData.current.wind_kph! * 1000/3600))  + " m/c"
        windLable.font = UIFont(name: "georgia", size: 32)
        wind_dirLable.text = String(windId.wind_dirArray[weatherData.current.wind_dir!]!)
        wind_dirLable.font = UIFont(name: "georgia", size: 24)
        locationLable.text = weatherData.location.name
        locationLable.textAlignment = .center
        locationLable.numberOfLines = 2
        locationLable.font = UIFont(name: "georgia", size: 40)
        return headerView
    }
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.lowTempLabel.text = weatherArray[indexPath.row].day.mintemp_c.description + " °C"
        cell.HayTempLabel.text = weatherArray[indexPath.row].day.maxtemp_c.description + " °C /"
        cell.maxwind_kphLable.text = String(format: "%.0f", (weatherArray[indexPath.row].day.maxwind_kph * 1000/3600)) + " m/c"
       // так получилось кодить кортинку по коду который приходит
        cell.iconImage.image = UIImage(named: String(iconId.iconArray[weatherArray[indexPath.row].day.condition.code]!))
        //конертируем дату в удобный формат
        let day = getDayFormatted(date: Date(timeIntervalSince1970:Double (weatherArray[indexPath.row].date_epoch!)))
  
        cell.dataLabel.text = dayId.dayArray[day]            
        cell.backgroundColor = UIColor(red: 32/255.0, green: 178/255.0, blue: 170/255.0, alpha: 1.0 )
           
        return cell
    }
                                              
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
        
    }
    // форматируем дату
    func getDayFormatted(date:Date?) -> String{
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
}
    

 
   


            

           



