//
//  GlobalHelpers.swift
//  Weather Plus
//
//  Created by joe_mac on 01/30/2021.
//

import Foundation

func currentDateFromUnix(unixDate: Double?) -> Date? {
    if unixDate != nil {
        return Date(timeIntervalSince1970: unixDate!)
    } else {
        return Date()
    }
}
