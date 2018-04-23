//
//  DayCell.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/30.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hourViewsHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: [WeatherList]) {
        clearPreloadedViews()
        let view = HourlyWeatherView(weather: data[0])
        
        hourViewsHolder.addSubview(view)
        hourViewsHolder.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view":view]))
        hourViewsHolder.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view":view]))
        
    }
    
    func clearPreloadedViews() {
        hourViewsHolder.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }

}
