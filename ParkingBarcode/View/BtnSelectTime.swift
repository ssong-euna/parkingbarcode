//
//  BtnSelectTime.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/30/25.
//

import SwiftUI

struct BtnSelectTime: View {
    let title: String
    let width: CGFloat
    let idx: Int
    let action: (Int) -> Void
    
    var body: some View {
        Button(action: {action(idx)}) {
            Text(title)
                .padding()
                .frame(maxWidth: width, alignment: .center)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
                .foregroundStyle(Color(hex: "#"))
        }
        .foregroundStyle(.black)
    }
}
