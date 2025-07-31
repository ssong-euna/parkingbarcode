//
//  BarcodeVM.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/31/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct BarcodeVM {
    static func makeBarcode(price: Int) -> (UIImage, String)? {
        let context = CIContext()
        let filter = CIFilter.code128BarcodeGenerator()
        
        let str = makeBarcodeString(price: price)
        
        let data = Data(str.utf8)
        
        filter.message = data
        
        if let outputImage = filter.outputImage {
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
            if let cgimage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return (UIImage(cgImage: cgimage), str)
            }
        }
        
        return nil
    }
    
    static private func makeBarcodeString(price: Int) -> String {
        var str = ""
        
        str += "yyyyMMddhhmmss".toTime()
        str += String(format: "%08d", price)
        str += "34"
        
        return str
    }
}
