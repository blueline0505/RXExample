//
//  ErrorType.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/28.
//

import Foundation

enum ErrorType: String, Decodable, Error {
    case ERROR_REQUEST_FAILED = "ERROR_REQUEST_FAILED"
    case ERROR_BAD_STATUS_CODE = "ERROR_BAD_STATUS_CODE"
    case ERROR_INVAILD_DECODE_FAILURE = "ERROR_INVAILD_DECODE_FAILURE"
    case ERROR_INVAILD_TIMEOUT = "ERROR_INVAILD_TIMEOUT"
    case ERROR_INVAILD_NOT_CONNECTED = "ERROR_INVAILD_NOT_CONNECTED"
    case ERROR_INVAILD_OTHER_FAILLURE = "ERROR_INVAILD_OTHER_FAILLURE"
    
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = ErrorType(rawValue: label) ?? .ERROR_INVAILD_OTHER_FAILLURE
    }
}
