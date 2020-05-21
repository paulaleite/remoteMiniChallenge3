//
//  Extension.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit

enum DateFormatType: String {
    /// Time
    case time = "HH:mm:ss"

    /// Date with hours
    case dateWithTime = "dd MMM yyyy   H:mm"

    /// Date
    case date = "dd/MM/yyyy"
}

extension Date {
    
    func convertToString(dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
}
