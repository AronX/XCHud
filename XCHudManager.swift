//
//  XCHudManager.swift
//  COCXM
//
//  Created by 橙子徐 on 2022/6/29.
//

import SwiftUI
import Foundation

public final class XCHudManager : ObservableObject {
    public enum XCHudStyle {
        case message
        case loading
        case success
        case error
        case info
        case custom
    }

    
    static let manager = XCHudManager()
    ///这里设置了两个展示的属性，因为展示的过程有动画，但是动画过程中，即加载HUD的过程中，下面的界面还能响应，所以这里的处理是一开始就把底图(透明挡板)放上,然后中间内容做动画
    @Published var isHudShowing: Bool = false
    @Published var isMaskShowing: Bool = false
    @Published var image: Image?
    var style : XCHudStyle = .message
    var text: String?
    
    private var isAnimating = false
    
    // MARK: public
    public static func show(_ text: String) {
        manager.show(.message, text)
    }
    
    public static func show(_ style:XCHudStyle,_ text: String) {
        manager.show(style, text)
    }
    
    public static func show(_ image:Image,_ text: String) {
        manager.show(image, .custom, text)
    }
    
    public static func hideHud() {
        manager.hideHud()
    }
    
    // MARK: private
    private func show(_ style:XCHudStyle,_ text: String) {
        switch style {
        case .message:
            show(nil, style, text)
        case .custom:
            show(nil, style, text)
        case .loading:
            show(Image(systemName: "arrow.triangle.2.circlepath.circle"), style, text)
        case .success:
            show(Image(systemName: "checkmark.circle"), style, text)
        case .error:
            show(Image(systemName: "multiply.circle"), style,text)
        case .info:
            show(Image(systemName: "exclamationmark.circle"), style, text)
        }
    }
    
    private func show(_ image:Image?,_ style:XCHudStyle,_ text: String) {
        self.text = text
        self.image = image
        self.style = style
        isHudShowing = true
        isMaskShowing = true
        if style != .loading {
            startDispatchTime()
        }
    }
    
    private func hideHud() {
        withAnimation {
            isHudShowing = false
        }
    }
    private func startDispatchTime() {
        if isAnimating {
            return
        }
        isAnimating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.isHudShowing = false
                self.isMaskShowing = false
                self.isAnimating = false
            }
        }
    }
}
