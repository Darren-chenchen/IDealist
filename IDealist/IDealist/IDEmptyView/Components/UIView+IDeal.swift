//
//  UIView+IDeal.swift
//  IDEmptyView
//
//  Created by implion on 2018/12/7.
//

import Foundation
import UIKit

extension UIView {

    static var IDEmptyViewKey: UInt8 = 0
    public var id_empty: IDEmptyView? {
        
        get {
            return (objc_getAssociatedObject(self, &UIView.IDEmptyViewKey) as? IDEmptyView)
        }
        
        set {
            if let view = newValue {
                self.id_empty?.removeFromSuperview()
                self.insertSubview(view, at: self.subviews.count)
                objc_setAssociatedObject(self, &UIView.IDEmptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
