//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by  Сергей on 19.03.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var maxwind_kphLable: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var HayTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifier = "WeatherTableViewCell"
    // не знаю для чего эта функция
    static func nib() -> UINib {
            return UINib(nibName: "WeatherTableViewCell", bundle: nil)
        }

    //создаем функцию
   // func configure(model: Forecast) {
       // lowTempLabel.text = "\(String(describing: model.forecastday.day.capacity))"  //  так можно конвертировать из Int в string"
       // HayTempLabel.text = "\(String(describing: model.forecastday.capacity))"
    //}
}
