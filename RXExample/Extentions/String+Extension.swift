//
//  String+Extension.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import Foundation

extension String {
    
    func toString(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ", outputFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else {
            return ""
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return outputFormatter.string(from: date)
    }
}
