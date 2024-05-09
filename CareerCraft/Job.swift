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
    var location: String?
    var minSalary: String?
    var maxSalary: String?
    var workStyleIndex: Int?
    var workTimeIndex: Int?
    
    var hasbonusFrequency: Bool
    var hasSocialSecurity: Bool
    var hasProvidentFund: Bool
    var hasEquipment: Bool
    
    @Attribute(.externalStorage)
    var imageData: Data?
    
//    @Transient var workStyle: WorkStyle {
//        get {
//            return WorkStyle(rawValue: String(workStyleValue)) ?? .onsite }
//        set {
//            self.workStyleValue = String(newValue.rawValue)
//        }
//    }
//    @Attribute(originalName: "workStyle") var workStyleValue: WorkStyle.RawValue
//    
//    @Transient var workTime: WorkTime {
//        get {
//            return WorkTime(rawValue: String(workTimeValue)) ?? .fixed }
//        set {
//            self.workTimeValue = String(newValue.rawValue)
//        }
//    }
//    @Attribute(originalName: "workTime") var workTimeValue: WorkTime.RawValue
    
//    var welfare: Welfare?
    
    
    init(company: String,
         department: String?,
         minSalary: String?,
         maxSalary: String?,
         location: String?,
         workStyleIndex: Int?,
         workTimeIndex: Int?,
         hasbonusFrequency: Bool?,
         hasSocialSecurity: Bool?,
         hasProvidentFund: Bool?,
         hasEquipment: Bool?,
         imageData: Data?
    ) {
        
        self.company = company
        self.department = department ?? ""
        self.minSalary = minSalary ?? ""
        self.maxSalary = minSalary ?? ""
        self.location = location ?? ""
        self.workStyleIndex = workStyleIndex ?? -1
        self.workTimeIndex = workStyleIndex ?? -1
        self.hasbonusFrequency = hasbonusFrequency ?? false
        self.hasSocialSecurity = hasSocialSecurity ?? false
        self.hasProvidentFund = hasProvidentFund ?? false
        self.hasEquipment = hasEquipment ?? false
        self.imageData = imageData ?? nil
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


