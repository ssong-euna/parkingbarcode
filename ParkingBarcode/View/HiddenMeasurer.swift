//
//  HiddenMeasurer.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/30/25.
//

import SwiftUICore

struct HiddenMeasurer: View {
    let titles: [String]
    let onMeasure: (CGFloat) -> Void

    var body: some View {
        VStack {
            ForEach(titles, id: \.self) { title in
                Text(title)
                    .padding()
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .preference(key: SizePreferenceKey.self, value: geo.size.width)
                        }
                    )
                    .hidden() // 화면에는 안 보이게!
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: onMeasure)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
