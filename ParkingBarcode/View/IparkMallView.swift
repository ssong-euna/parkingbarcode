//
//  IparkMallView.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/31/25.
//

import SwiftUI

struct IparkMallView: View {
    let arrRules: [[String: Int]] = [
        ["1시간": 10000],
        ["2시간": 30000],
        ["3시간": 50000],
        ["4시간": 100000],
        ["5시간": 200000]
    ]
    @State private var maxWidth: CGFloat = 0
    @State private var isSelected: Bool = false
    @State private var barcodeImg = UIImage()
    @State private var barcodeStr: String = ""
    
    var keys: [String] {
        return arrRules.compactMap { $0.keys.first }
    }
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 20) {
                ForEach(Array(arrRules.enumerated()), id: \.offset) { index, rule in
                    if let title = rule.keys.first,
                       let time = rule.values.first {
                        BtnSelectTime(title: title, width: maxWidth, idx: index, action: { index in
                            if let (image, str) = BarcodeVM.makeBarcode(type: .iparkamall, price: time) {
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
            
            NavigationLink(
                destination: BarcodeView(image: $barcodeImg, str: $barcodeStr),
                isActive: $isSelected
            ) {
                EmptyView()
            }
        }
        .navigationTitle("아이파크몰")
    }
}

#Preview {
    IparkMallView()
}
