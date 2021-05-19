//
//  ViewController.swift
//  SalaryPerSecond
//
//  Created by worker on 03.02.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var workedTotalSeconds: Int?
    var dateService: DateService?
    var salaryOverPastTime: Double?
    var salaryPerDay: Double?
    var timer = Timer()
    
    private var salaryPerSecondLabel:UILabel! {
        didSet {
            self.salaryPerSecondLabel.backgroundColor = .systemYellow
            self.salaryPerSecondLabel.layer.cornerRadius = 20.0
            self.salaryPerSecondLabel.layer.masksToBounds = true
            self.salaryPerSecondLabel.text = "0.0"
            self.salaryPerSecondLabel.textColor = .black
            self.salaryPerSecondLabel.textAlignment = .center
            self.salaryPerSecondLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        }
    }
    
    private var salaryPerDayField:UITextField! {
        didSet {
            self.salaryPerDayField.backgroundColor = .systemGray3
            self.salaryPerDayField.placeholder = "Salary"
            self.salaryPerDayField.textColor = .brown
            self.salaryPerDayField.textAlignment = .center
            self.salaryPerDayField.font = UIFont.systemFont(ofSize: 25, weight: .medium)
            self.salaryPerDayField.borderStyle = .roundedRect
        }
    }
    
    func scheduledTimerWithTimeInterval() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.workedTotalSeconds = self.dateService?.getTotalWorkedSeconds()
            self.salaryOverPastTime = SalaryService.getSalaryOverPastTime(self.workedTotalSeconds!, self.salaryPerDay)
            self.salaryPerSecondLabel.text = String(self.salaryOverPastTime!)
            print(self.salaryOverPastTime)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        setupViews()
        setupConstraints()
        
        self.salaryPerDay = 0
        
        self.dateService = DateService.shared
        self.dateService?.setStartDate(hour: 16, minute: 50, second: 0)

        scheduledTimerWithTimeInterval()
    }
    
    func setupViews() {
        self.salaryPerSecondLabel = UILabel()
        self.view.addSubview(self.salaryPerSecondLabel)
        
        self.salaryPerDayField = UITextField()
        self.salaryPerDayField.delegate = self
        self.view.addSubview(self.salaryPerDayField)
    }
    
    func setupConstraints() {
        self.salaryPerSecondLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.center.y / 2)
            make.height.equalTo(100)
            make.width.equalTo(self.view.bounds.width / 4 * 3)
        }
        
        self.salaryPerDayField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.salaryPerSecondLabel.snp.bottom).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(self.view.bounds.width / 4 * 2)
        }
    }
    
    //MARK: - Delegates
    
  func textFieldDidChangeSelection(_ textField: UITextField) {
    self.salaryPerDay = Double(textField.text!)
  }
}
