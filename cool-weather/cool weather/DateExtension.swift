//
//  DateExtension.swift
//  cool weather
//
//  Created by Matthew on 28.06.22.
//

import Foundation


extension Date {

    var today: Date? {
        return Calendar.current.date(byAdding: .day, value: 0, to: self)
    }
    
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    var theDayAfterTomorrow: Date? {
        
        return Calendar.current.date(byAdding: .day, value: 2, to: self)
    }
}
