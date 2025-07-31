//
//  StringExtention.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/31/25.
//

import UIKit

extension String {
    func toTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = self
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간
        return formatter.string(from: Date())
    }
}
