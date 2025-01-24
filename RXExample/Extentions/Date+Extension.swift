//
//  String+Extension.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/5/4.
//

import Foundation
extension Date {
    func nowToString(_ formatter: String) -> String { // "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let df = DateFormatter()
        df.dateFormat = formatter
        df.timeZone = .current
        return df.string(from: self)
    }
    
    func toShortString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
    
    func toString(outputFormat: String) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return outputFormatter.string(from: self)
    }
}
