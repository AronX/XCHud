//
//  XCSpinning.swift
//  XCHudView
//
//  Created by ARONX on 2022/6/29.
//

import SwiftUI

extension View {
   func spinning() -> some View {
      self.modifier(XCSpinning())
   }
}
struct XCSpinning: ViewModifier {
   @State var isVisible = false
   func body(content: Content) -> some View {
      content
         .rotationEffect(Angle(degrees: isVisible ? 360 : 0))
         .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
         .onAppear { self.isVisible = true }
   }
}


