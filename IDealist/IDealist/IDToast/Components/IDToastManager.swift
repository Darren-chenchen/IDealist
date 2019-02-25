//
//  HDToastQueue.swift
//  Ideal
//
//  Created by darren on 2018/8/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

public class IDToastManager {
    public static let share = IDToastManager()
    
    public var successImage = UIImage(named: "ic_toast_success", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    public var failImage = UIImage(named: "icn_icn_fail", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    public var warnImage = UIImage(named: "icon_sign", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)

    public var bgColor = UIColor.black
    public var textColor = UIColor.white
    public var textFont = UIFont.systemFont(ofSize: 16)
    public var cornerRadius: CGFloat = 5
    public var supportQuene: Bool = true

    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public func id_resetDefaultProps() {
        self.common()
    }
    
    @available(*, deprecated, message: "Use 'cl_reset' instead.")
    public func reset() {
        self.common()
    }
    
    func common() {
        self.bgColor = UIColor.black
        self.textColor = UIColor.white
        self.textFont = UIFont.systemFont(ofSize: 16)
        self.cornerRadius = 5
        self.successImage = UIImage(named: "ic_toast_success", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        self.failImage = UIImage(named: "icn_icn_fail", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        self.warnImage = UIImage(named: "icon_sign", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        
        self.supportQuene = true
    }
    
    func add(_ toast: IDToastUtils) {
        self.queue.addOperation(toast)
    }
    public func cancelAll() {
        self.queue.cancelAllOperations()
    }
}
