//
//  BarcodeVM.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/31/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import ZXingObjC

struct BarcodeVM {
    static func makeBarcode(type: Options, price: Int) -> (UIImage, String)? {
        func make128Barcode(str: String) -> UIImage {
            let context = CIContext()
            let filter = CIFilter.code128BarcodeGenerator()
            
            let data = Data(str.utf8)
            
            filter.message = data
            
            if let outputImage = filter.outputImage {
                let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
                if let cgimage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                    return (UIImage(cgImage: cgimage))
                }
            }
            
            return UIImage()
        }
        
        func makeITFBarcode(str: String) -> UIImage {
            let writer = ZXMultiFormatWriter()
            
            do {
                let hints = ZXEncodeHints()
                hints.margin = NSNumber(value: Int64(20))
                
                let bitMatrix = try writer.encode(
                    str,
                    format: kBarcodeFormatITF,
                    width: Int32(200),
                    height: Int32(20),
                    hints: hints
                )
                
                if let zxImage = ZXImage(matrix: bitMatrix) {
                    return UIImage(cgImage: zxImage.cgimage)
                }
            } catch {
                return UIImage()
            }
            
            return UIImage()
        }
        
        switch type {
        case .none:
            break
        case .homeplus:
            let str = makeHomeplusBarcodeString(price: price)
            return (make128Barcode(str: str), str)
        case .iparkamall:
            let str = makeIparkMallBarcodeString(price: price)
            return (make128Barcode(str: str), str)
        case .traders:
            let str = makeTradersBarcodeString(price: price)
            return (makeITFBarcode(str: str), str)
        }
        
        return nil
    }
    
    static private func makeHomeplusBarcodeString(price: Int) -> String {
        var str = ""
        
        str += "yyyyMMddHHmmss".toTime()
        str += String(format: "%08d", price)
        str += "34"
        
        return str
    }
    
    static private func makeIparkMallBarcodeString(price: Int) -> String {
        var str = ""
        
        str += "026100932"
        str += "yyyyMMddhhmmss".toTime()
        str += "03413"
        
        return str
    }
    
    static private func makeTradersBarcodeString(price: Int) -> String {
        var str = ""
        
        str += "yyyyMMdd".toTime()
        str += "87016694"
        str += String(format: "%08d", price)
        str += "26"
        
        return str
    }
}
