import Foundation

class SalaryService {
    
    static var overTime: Int? = 0
    
    private static func getSalaryPerSecond(_ salary: Double?) -> Double? {
        guard let salary = salary else { return nil }
        let salaryForSecond = salary / (8 * 60 * 60)
        return salaryForSecond
    }
    
    static func getSalaryOverPastTime(_ overPastTime: Int, _ salaryPerDay: Double?) -> Double? {
        guard let salaryPerSecond = SalaryService.getSalaryPerSecond(salaryPerDay) else { return nil }
        let totalSalary = salaryPerSecond * Double(overPastTime)
        let roundTotalSalary = Double(round(1000*totalSalary)/1000)
        return roundTotalSalary
    }
}
