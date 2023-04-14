//
//  HourlyTableViewCell.swift
//  MyWeather
//
//  Created by  Сергей on 19.03.2022.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    static let identifier = "HourlyTableViewCell"
    // не знаю для чего эта функция
    static func nib() -> UINib {
            return UINib(nibName: "HourlyTableViewCell", bundle: nil)
        }
}
