//
//  CityViewController.swift
//  OpenWeatherApp
//
//  Created by Zwelithini Mathebula on 2018/03/28.
//  Copyright © 2018 Zwelithini Mathebula. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CityViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var viewModel: CitiWeatherViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        
        viewModel = CitiWeatherViewModel()
        setupView()
    }
    
    func setupView() {
        let observableWeather =  viewModel.weatherArrangedByDate.asObservable()
        observableWeather.bind(to: tableView.rx.items(cellIdentifier: "DayCell", cellType: DayCell.self)) { (row, dayData, cell) in
            cell.nameLabel.text = dayData[0].day
            cell.configure(data: dayData)
        }
        .disposed(by: disposeBag)
    }
}
