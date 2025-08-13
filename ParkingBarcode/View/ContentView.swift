//
//  ContentView.swift
//  ParkingBarcode
//
//  Created by 송은아 on 7/30/25.
//

import SwiftUI

enum Options: String, CaseIterable {
    case none = "지점을 선택해주세요"
    case homeplus = "홈플러스"
    case iparkamall = "아이파크몰"
    case traders = "트레이더스"
}

struct ContentView: View {
    @State private var selectedOption: Options = .none
    @State private var isExpanded = false
    @State private var isSelected = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            
            Text("바코드 생성기")
                .padding()
                .font(.largeTitle)
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Button(action: {
                        isExpanded.toggle()
                    }) {
                        HStack {
                            Text(selectedOption.rawValue)
                            Spacer()
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke())
                    }
                    
                    if isExpanded {
                        ForEach(Options.allCases.filter { $0 != .none }, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                                isExpanded = false
                            }) {
                                Text(option.rawValue)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .foregroundStyle(Color.init(hex: "#222222"))
                        .background(RoundedRectangle(cornerRadius: 8).stroke())
                    }
                }
                .foregroundStyle(Color.init(hex: "#222222"))
                .animation(.default, value: isExpanded)
                .padding()
                
                Button(action: {
                    isSelected.toggle()
                }, label: {
                    Text("확인")
                        .font(Font.system(size: 20, weight: .bold))
                })
                .padding()
                .foregroundStyle(Color.init(hex: "#ffffff"))
                .background(Color.init(hex: "#df0011"))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Spacer()
            }
            
            Spacer()
            
            NavigationLink(
                destination: destinationView,
                isActive: $isSelected
            ) {
                EmptyView()
            }
        }
    }
    
    var destinationView: AnyView {
        switch selectedOption {
        case .none:
            return AnyView(EmptyView())
        case .homeplus:
            return AnyView(HomeplusView())
        case .iparkamall:
            return AnyView(IparkMallView())
        case .traders:
            return AnyView(TradersView())
        }
    }
}
