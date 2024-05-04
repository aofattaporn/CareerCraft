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
    
    @Transient var workStyle: WorkStyle {
        get {
            return WorkStyle(rawValue: String(workStyleValue)) ?? .onsite }
        set {
            self.workStyleValue = String(newValue.rawValue)
        }
    }
    @Attribute(originalName: "workStyle") var workStyleValue: WorkStyle.RawValue
    
    @Transient var workTime: WorkTime {
        get {
            return WorkTime(rawValue: String(workTimeValue)) ?? .fixed }
        set {
            self.workTimeValue = String(newValue.rawValue)
        }
    }
    @Attribute(originalName: "workTime") var workTimeValue: WorkTime.RawValue
    
//    var welfare: Welfare?
    
    var hasbonusFrequency: Bool
    var hasSocialSecurity: Bool
    var hasProvidentFund: Bool
    var hasEquipment: Bool

    
    
    init(company: String,
         department: String?,
         salaryRange: String?,
         location: String?,
         workStyle: WorkStyle?,
         workTime: WorkTime?,
         hasbonusFrequency: Bool?,
         hasSocialSecurity: Bool?,
         hasProvidentFund: Bool?,
         hasEquipment: Bool?
    ) {
        
        self.company = company
         self.department = department ?? ""
         self.salaryRange = salaryRange ?? ""
         self.location = location ?? ""
         self.workStyleValue = workStyle?.rawValue ?? ""
         self.workTimeValue = workTime?.rawValue ?? ""
         self.hasbonusFrequency = hasbonusFrequency ?? false
         self.hasSocialSecurity = hasSocialSecurity ?? false
         self.hasProvidentFund = hasProvidentFund ?? false
         self.hasEquipment = hasEquipment ?? false
    }
}

enum WorkStyle: String {
    case onsite = "onsite"
    case online = "online"
    case hybrid = "hybrid"
}

enum WorkTime: String{
    case flexible  = "flexible"
    case fixed  = "fixed"
}


struct Welfare {
    var hasbonusFrequency: Bool
    var hasSocialSecurity: Bool
    var hasProvidentFund: Bool
    var hasEquipment: Bool
}


