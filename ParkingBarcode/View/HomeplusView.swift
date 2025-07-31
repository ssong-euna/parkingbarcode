//
//  HomeplusView.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/31/25.
//

import SwiftUI

struct HomeplusView: View {
    var body: some View {
        HStack(spacing: 20) {
            ForEach(Array(arrRules.enumerated()), id: \.offset) { index, rule in
                if let title = rule.keys.first,
                   let time = rule.values.first {
                    BtnSelectTime(title: title, width: maxWidth, idx: index, action: { index in
                        if let (image, str) = BarcodeVM.makeBarcode(price: time) {
                            barcodeImg = image
                            barcodeStr = str
                            isSelected = true
                        }
                    })
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 10)
        .background(
            HiddenMeasurer(titles: keys) { max in
                self.maxWidth = max
            }
        )
        
        Spacer()
    }
}

#Preview {
    HomeplusView()
}
