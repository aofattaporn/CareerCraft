//
//  Job.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import Foundation
import SwiftData

@Model
final class Job {
    
    var company: String
    var department: String?
    var salaryRange: String?
    var location: String?
    var workStyle: WorkStyle
    var workTime: WorkTime
    var welfare: Welfare
    
    
    init(company: String,
         department: String?,
         salaryRange: String?,
         location: String?,
         workStyle: WorkStyle,
         workTime: WorkTime,
         welfare: Welfare,
         equipment: String) {
        self.company = company
        self.department = department
        self.salaryRange = salaryRange
        self.workStyle = workStyle
        self.workTime = workTime
        self.location = location
        self.welfare = welfare
    }
}

enum WorkStyle {
    case onsite
    case online
    case hybrid
}

enum WorkTime {
    case flexible
    case fixed
}


struct Welfare {
    var hasbonusFrequency: Bool
    var hasSocialSecurity: Bool
    var hasProvidentFund: Bool
    var hasEquipment: Bool
}


