//
//  StandardDateHandler.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import Foundation

enum StandardDateHandler {
    static func getTimeMessage(date: Date) -> String? {
        transformDate(date: date, to: DateFormatter.formatHHmmA)
    }
    
    static func getDateMessage(date: Date) -> String? {
        transformDate(date: date, to: DateFormatter.formatMMMddYYY)
    }
    
    static func transformDate(date: Date, to: String) -> String? {
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = to
        let formattedString = toDateFormatter.string(from: date)
        return formattedString
    }
}
