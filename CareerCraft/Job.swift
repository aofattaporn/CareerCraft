//
//  Job.swift
//  CareerCraft
//
//  Created by attaporn on 4/17/24.
//

import Foundation
import SwiftData

enum WorkStyle: String {
    case onsite = "onsite"
    case online = "online"
    case hybrid = "hybrid"
    case unknown = "unknown"
}

enum WorkTime: String{
    case flexible  = "flexible"
    case fixed  =   "fixed"
    case unknown = "unknown"
}

@Model
final class Job {
    
    @Transient var workStyle: WorkStyle {
        get {
            return WorkStyle(rawValue: String(workStyleValue)) ?? .unknown }
        set {
            self.workStyleValue = String(newValue.rawValue)
        }
    }
    
    
    @Transient var workTime: WorkTime {
        get {
            return WorkTime(rawValue: String(workTimeValue)) ?? .unknown }
        set {
            self.workTimeValue = String(newValue.rawValue)
        }
    }
    
    var company: String
    var department: String
    var location: String?
    var minSalary: Int?
    var maxSalary: Int?
    
    @Attribute(originalName: "workStyle") var workStyleValue: WorkStyle.RawValue
    @Attribute(originalName: "workTime") var workTimeValue: WorkTime.RawValue

    var hasbonusFrequency: Bool
    var hasSocialSecurity: Bool
    var hasProvidentFund: Bool
    var hasEquipment: Bool
    
    @Attribute(.externalStorage)
    var imageData: Data?
    
    init(
         company: String,
         department: String,
         location: String,
         minSalary: Int?,
         maxSalary: Int?,
         
         workStyleValue: WorkStyle,
         workTimeValue: WorkTime,

         hasbonusFrequency: Bool,
         hasSocialSecurity: Bool,
         hasProvidentFund: Bool,
         hasEquipment: Bool,
         imageData: Data?
         
         
    ) {
        
        self.company = company
        self.department = department
        self.location = (location.isEmpty) ? nil : location
    
        self.minSalary = minSalary
        self.maxSalary = maxSalary
        
        self.workStyleValue = workStyleValue.rawValue
        self.workTimeValue = workTimeValue.rawValue
        
        self.hasbonusFrequency = hasbonusFrequency
        self.hasSocialSecurity = hasSocialSecurity
        self.hasProvidentFund = hasProvidentFund
        self.hasEquipment = hasEquipment
        self.imageData = imageData
    }

    
}

struct Welfare {
    var hasbonusFrequency: Bool
    var hasSocialSecurity: Bool
    var hasProvidentFund: Bool
    var hasEquipment: Bool
}


