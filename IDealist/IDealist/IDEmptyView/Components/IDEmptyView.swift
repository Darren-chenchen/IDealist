//
//  IDEmptyView.swift
//  IDEmptyView
//
//  Created by implion on 2018/12/6.
//

import Foundation
import UIKit

public class IDEmptyView: UIView {
    
    public static var mainColor = UIColor.colorFromHex(0x0D7AFF)
    
    public enum Style {
        case normal
        case normalDeail(String)
        case normalOperational
        case normalDetailOperational(String)
        case load
        case loadDetail
        case detail(String)
        
        var stateText: String? {
            switch self {
            case .normal, .normalOperational, .normalDeail, .normalDetailOperational:
                return "暂无数据"
            case .loadDetail:
                return "加载失败"
            case .load:
                return "网络请求失败，请稍后重试"
            case .detail:
                return ""
            }
        }
        
        var detail: String {
            switch self {
            case let .normalDeail(text):
                return text
            case let .normalDetailOperational(text):
                return text
            case .loadDetail:
                return "请检查您的网络后重试"
            case .detail(let text):
                return text
            default:
                return ""
            }
        }
        
        var buttonText: String {
            return "重新加载"
        }
        
        var hasState: Bool {
            switch self {
            case .detail:
                return false
            default:
                return true
            }
        }
        
        var hasDetail: Bool {
            switch self {
            case .load, .normal, .normalOperational:
                return false
            default:
                return true
            }
        }
        
        var hasOperational: Bool {
            switch self {
            case .normalDeail, .normal, .detail:
                return false
            default:
                return true
            }
        }
    }
    
    let imageHeight: CGFloat = 100
    
    let margin: CGFloat = 20
    
    let per_padding: CGFloat = 8
    
    let stateHeight: CGFloat = 24
    
    var detailHeight: CGFloat = 24
    
    let buttonHeight: CGFloat = 36

    
    public typealias OperatorAction = () -> ()
    
    var style: Style = .normal {
        didSet {
            stateLabel.isHidden = !style.hasState
            detailLabel.isHidden = !style.hasDetail
            actionButton.isHidden = !style.hasOperational
            actionButton.setTitle(style.buttonText, for: .normal)
        }
    }
    
    var action: OperatorAction?
    
    var contentView: UIView!
    
    var stateLabel: UILabel!
    
    var detailLabel: UILabel!
    
    var actionButton: UIButton!
    
    var imageView: UIImageView!
    
    var imageName: String {
        switch style {
        case .normal, .normalDeail, .normalOperational, .normalDetailOperational:
            return "ic_empty@2x.png"
        default:
            return "ic_load_failure@2x.png"
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var stateText: String? {
        didSet {
            stateLabel.text = stateText
        }
    }
    
    var buttonText: String? {
        didSet {
            actionButton.setTitle(buttonText, for: .normal)
        }
    }
    
    var detailText: String? {
        didSet {
            detailLabel.text = detailText
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureEvent()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if bounds.size == CGSize(width: 0, height: 0), let newSuper = newSuperview { self.frame = newSuper.bounds }
        doLayout()
    }
    
    func configureView() {
        contentView = UIView()
        stateLabel = UILabel()
        detailLabel = UILabel()
        imageView = UIImageView()
        actionButton = UIButton(type: .system)
        contentView.addSubview(imageView)
        contentView.addSubview(stateLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(actionButton)
        addSubview(contentView)
        stateLabel.textColor = UIColor.colorFromHex(0x17202E)
        detailLabel.textColor = UIColor.colorFromHex(0x60666F)
        actionButton.backgroundColor = IDEmptyView.mainColor
        stateLabel.font = UIFont.systemFont(ofSize: 18.0)
        stateLabel.textAlignment = .center
        detailLabel.font = UIFont.systemFont(ofSize: 14.0)
        detailLabel.textAlignment = .center
        actionButton.layer.cornerRadius = 4.0
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        actionButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func doLayout() {
        let width = UIScreen.main.bounds.size.width
        let contentViewW = width - 2 * margin
        var contentViewH: CGFloat = 0
        contentView.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        imageView.center = CGPoint(x: contentView.center.x - margin, y: imageHeight / 2)
        imageView.bounds = CGRect(x: 0, y: 0, width: imageHeight, height: imageHeight)
        contentViewH += imageHeight
        var stateH = stateText?.calculateHeight(stateLabel.font, width: contentViewW) ?? stateHeight
        stateH = max(stateH, stateHeight)
        stateLabel.frame = CGRect(x: 0, y: imageHeight + per_padding, width: contentViewW, height: stateH)
        if stateLabel.isHidden {
            stateH = 0
            contentViewH += per_padding
        } else {
            contentViewH += stateH + per_padding
        }
        var detailH = detailText?.calculateHeight(detailLabel.font, width: contentViewW) ?? detailHeight
        detailLabel.frame = CGRect(x: 0, y: contentViewH, width: contentViewW, height: detailHeight)
        detailH = max(detailH, detailHeight)
        if detailLabel.isHidden {
            detailH = 0
        } else {
            contentViewH += detailH
        }
        actionButton.center = CGPoint(x: contentView.center.x - margin, y: contentViewH + per_padding + buttonHeight / 2)
        actionButton.bounds = CGRect(x: 0, y: 0, width: 100, height: buttonHeight)
        if !actionButton.isHidden {
            contentViewH += buttonHeight + per_padding
        }
        contentView.bounds = CGRect(x: 0, y: 0, width: contentViewW, height: contentViewH)
    }
    
    func configureEvent() {
        actionButton.addTarget(self, action: #selector(actionButtonClick), for: .touchUpInside)
    }
    
    @objc func actionButtonClick() {
        if let action = action {
            action()
        }
    }
    
    //MAKR: - Public Methods
    public class func create() -> IDEmptyView {
        let emptyView = IDEmptyView()
        return emptyView
    }
    
    public func setOperatorAction(_ action: @escaping OperatorAction) -> IDEmptyView {
        self.action = action
        return self
    }
    
    public func custom(image: UIImage? = nil,
                       title: String? = nil,
                       detail: String? = nil,
                       buttonText: String? = nil) -> IDEmptyView {
        if let image = image { self.image = image }
        if let title = title { self.stateText = title }
        if let detail = detail { self.detailText = detail }
        if let buttonText = buttonText { self.buttonText = buttonText }
        return self
    }
    
    public func configStyle(_ style: Style? = .normal) -> IDEmptyView {
        self.style = style ?? .normal
        self.image = self.image ?? UIImage.imageNamed(imageName, aClass: self.classForCoder)
        self.detailText = self.detailText ?? style?.detail
        self.stateText = self.stateText ?? style?.stateText
        return self
    }
    
}

extension String {
    func calculateHeight(_ font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: 99999)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func calculateWidth(_ font: UIFont, height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: 99999, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension UIImage {
    class func imageNamed(_ name: String, aClass: AnyClass) -> UIImage? {
        return UIImage(named: name, in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    }
}

extension UIColor {
    class func colorFromHex(_ rgbValue: Int) -> (UIColor) {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                     green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                     blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                     alpha: 1.0)
    }
}
