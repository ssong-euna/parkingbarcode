//
//  BarcodeView.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/31/25.
//

import SwiftUI

struct BarcodeView: View {
    @Binding var image: UIImage
    @Binding var str: String
    
    var body: some View {
        Image(uiImage: image)
            .interpolation(.none)
            .resizable()
            .frame(width: 200, height: 300)
        
        Spacer()
        
        Text(str)
        
        Spacer()
        
        Image(uiImage: image)
            .interpolation(.none)
            .resizable()
            .frame(height: 300)
    }
}
