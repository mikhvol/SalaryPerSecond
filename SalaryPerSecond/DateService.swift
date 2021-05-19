//
//  DateService.swift
//  SalaryPerSecond
//
//  Created by worker on 04.02.2021.
//

import Foundation

class DateService {
    
    static var shared: DateService! = {
        let dateService = DateService()
        return dateService
    }()
    
    private var currentSeconds: Int!
    private var startSeconds: Int!
    
    private func getCurrentSeconds() -> Int? {
        let currentDateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        guard let currentHour = currentDateComponents.hour,
              let currentMinute = currentDateComponents.minute,
              let currentSecond = currentDateComponents.second else { return nil }
        return getSeconds(hour: currentHour, minute: currentMinute, second: currentSecond)
    }
    
    func setStartDate(hour: Int, minute: Int, second: Int) {
        self.startSeconds = getSeconds(hour: hour, minute: minute, second: second)
    }
    
    private func getSeconds(hour: Int, minute: Int, second: Int) -> Int {
        let seconds = hour * 60 * 60 + minute * 60 + second
        return seconds
    }
    
    func getTotalWorkedSeconds() -> Int {
        if let currentSeconds = getCurrentSeconds() {
            return currentSeconds - self.startSeconds
        } else {
            print("No current seconds")
        }
        return 0
    }
    
    private init() {}
}

extension DateService: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
