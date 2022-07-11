//
//  XCHudView.swift
//  XCHudView
//
//  Created by ARONX on 2022/6/29.
//
enum XCHudType {
    case text
    case icon
    case textIcon
}
import SwiftUI

struct XCHUDView: View {
    @ObservedObject var viewModel = XCHudManager.manager
    var body: some View {
        ZStack {
            if viewModel.isHudShowing {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(white: 0.01, opacity: 0.01))
                    .ignoresSafeArea()
                if viewModel.isMaskShowing {
                    VStack {
                        if viewModel.image != nil {
                            if viewModel.style == .loading {
                                viewModel.image
                                    .spinning()
                                    .padding([.top,.leading,.trailing,.bottom],10)
                                    .foregroundColor(Color.white)
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .aspectRatio(contentMode: ContentMode.fill)
                            } else {
                                viewModel.image!
                                    .resizable()
                                    .padding([.top,.leading,.trailing,.bottom],10)
                                    .foregroundColor(Color.white)
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .scaledToFit()
                            }
                        }
                        
                        if viewModel.text != nil {
                            Text(viewModel.text ?? "")
                                .foregroundColor(.white)
                        }
                    }.padding(.horizontal, 0)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8).fill(Color.hex(0x000000, 0.7))
                                .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
                        )
                        .frame(maxWidth:UIScreen.main.bounds.width - 50, maxHeight: 400)
                }
            }
        }
    }
}

