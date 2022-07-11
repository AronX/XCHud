//
//  XCHud.swift
//  XCHudView
//
//  Created by ARONX on 2022/6/29.
//

import SwiftUI

public final class XCHud: ObservableObject {
    public static func show(_ message: String) {
        XCHudManager.show(.message, message)
    }
   
    public static func showError(_ message: String) {
        XCHudManager.show(.error, message)
    }
    
    public static func showSuccess(_ message: String) {
        XCHudManager.show(.success, message)
    }
    
    public static func showLoading(_ message: String) {
        XCHudManager.show(.loading, message)
    }
    
    public static func dismissHud() {
        XCHudManager.hideHud()
    }
   
}
extension View {
   public func showXCHud() -> some View {
      self.modifier(XHud())
   }
}
struct XHud: ViewModifier {
   func body(content: Content) -> some View {
      ZStack(alignment: .center) {
         content
         XCHUDView()
            .zIndex(1)
      }
   }
}
