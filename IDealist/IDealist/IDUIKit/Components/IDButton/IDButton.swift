//
//  IDButton.swift
//  IDUIKit-ios
//
//  Created by darren on 2019/2/12.
//  Copyright © 2019年 陈亮陈亮. All rights reserved.
//

import UIKit
public enum IDButtonType {
    case normal
    case primary
    case error
    case loading
}
public enum IDButtonPosition {
    case left     // 图片在文字左侧
    case right    // 图片在文字右侧
    case top      // 图片在文字上侧
    case bottom   // 图片在文字下侧
}
public enum IDButtonGradientDirection {
    case horizontally
    case vertically
}

open class IDButton: UIButton {

    /// 图片位置
    open var id_imagePosition = IDButtonPosition.left {
        didSet {
            self.layoutIfNeeded()
        }
    }
    /// 图片和文字之间的间距
    open var id_imageTitleSpace: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    /// loading视图和文字之间的间距
    open var id_loadingTitleSpace: CGFloat = 5 {
        didSet {
        }
    }    
    /// 按钮类型
    open var id_type: IDButtonType = .normal {
        didSet {
            self.common()
        }
    }
    /// 是否可用
    open var id_disable = false {
        didSet {
            if id_disable {
                self.alpha = 0.5
                self.isUserInteractionEnabled = false
            } else {
                self.alpha = 1
                self.isUserInteractionEnabled = true
            }
        }
    }
    /// 加载框大小
    open var id_loadingSize: CGSize = CGSize.init(width: 15, height: 15) {
        didSet {
            self.loadingWidthConstant.constant = id_loadingSize.width
            self.loadingHeightConstant.constant = id_loadingSize.height
            self.loadingView.radius = id_loadingSize.width / 2.0
            self.setNeedsLayout()
        }
    }
    private var loadingView: IDRefreshLoadingView = {
        let loading = IDRefreshLoadingView.init(frame: CGRect.zero)
        loading.radius = 7.5
        return loading
    }()
    var loadingCenterXConstant = NSLayoutConstraint()
    var loadingWidthConstant = NSLayoutConstraint()
    var loadingHeightConstant = NSLayoutConstraint()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.common()
        self.setupLoading()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.common()
        self.setupLoading()
    }
    public func id_startLoading() {
        // 调整位置
        let titleSize = self.calculateTitleSizeForSystemTitleSize(titleSize: self.titleLabel?.frame.size ?? CGSize.zero)
        let titleOffset = self.id_loadingSize.width + self.id_loadingTitleSpace
        let offset = titleSize.width * 0.5 + self.id_loadingSize.width * 0.5 + self.id_loadingTitleSpace - titleOffset * 0.5
        self.loadingCenterXConstant.constant = -offset
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: titleOffset, bottom: 0, right: 0)
        self.loadingView.isHidden = false
        self.loadingView.start()
    }
    public func id_stopLoading() {
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.loadingCenterXConstant.constant = 0
        self.loadingView.isHidden = true
        self.loadingView.end()
    }
    //MARK: - 渐变色
    public func id_setupGradient(gradientColors: [UIColor], gradientDirection direction: IDButtonGradientDirection, gradientFrame: CGRect? = nil) {
        //创建并实例化CAGradientLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //设置frame和插入view的layer
        if let gradientFrame = gradientFrame {
            gradientLayer.frame = gradientFrame
        }else {
            gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
        
        gradientLayer.colors = gradientColors.map({ (color) -> CGColor in
            return color.cgColor
        })
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        if direction == .horizontally {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        }else {
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        }
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    func setupLoading() {
        self.addSubview(self.loadingView)
        self.loadingView.isHidden = true
        self.layoutLoadingView()
    }
    func common() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
        if self.id_type == .primary {
            self.setupPrimary()
        }
        if self.id_type == .error {
            self.setupError()
        }
        if self.id_type == .normal {
            self.setupNormal()
        }
    }
    func layoutLoadingView() {
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.loadingWidthConstant = NSLayoutConstraint.init(item: self.loadingView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: self.id_loadingSize.width)
        self.loadingView.addConstraint(loadingWidthConstant)
        self.loadingHeightConstant = NSLayoutConstraint.init(item: self.loadingView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: self.id_loadingSize.height)
        self.loadingView.addConstraint(loadingHeightConstant)
        self.loadingCenterXConstant = NSLayoutConstraint.init(item: self.loadingView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        self.addConstraints([
            NSLayoutConstraint.init(item: self.loadingView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0),
            self.loadingCenterXConstant
            ])
    }
    func setupPrimary() {
        self.backgroundColor = IDealistConfig.share.mainColor
        self.layer.borderWidth = 0
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    func setupError() {
        self.backgroundColor = RGBAColor(233, 80, 79, 1)
        self.layer.borderWidth = 0
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    func setupNormal() {
        self.layer.borderWidth = 1
        self.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.backgroundColor = UIColor.white
    }
    
    override open func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        // 先获取系统为我们计算好的rect，这样大小图片在左右时我们就不要自己去计算,我门要改变的，仅仅是origin
        var imageRect = super.imageRect(forContentRect: contentRect)
        let titleRect = super.titleRect(forContentRect: contentRect)
        if (self.currentTitle == nil) { // 如果没有文字，则图片占据整个button，空格算一个文字
            return imageRect
        }
        switch self.id_imagePosition {
        case .left:
            imageRect = self.imageRectImageAtLeftForContentRect(contentRect: contentRect, imageRect: imageRect, titleRect: titleRect)
            break
        case .right:
                imageRect = self.imageRectImageAtRightForContentRect(contentRect: contentRect, imageRect: imageRect, titleRect: titleRect)
            break
        case .top:
            imageRect = self.imageRectImageAtTopForContentRect(contentRect: contentRect, imageRect: imageRect, titleRect: titleRect)
            break
        case .bottom:
            imageRect = self.imageRectImageAtBottomForContentRect(contentRect: contentRect, imageRect: imageRect, titleRect: titleRect)
            break
        }
        return imageRect
    }
    override open func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var titleRect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        if self.currentImage == nil {  // 如果没有图片
            return titleRect
        }
        switch (self.id_imagePosition) {
        case .left:
            titleRect = self.titleRectImageAtLeftForContentRect(contentRect: contentRect, titleRect: titleRect, imageRect: imageRect)
        break
        case .right:
            titleRect = self.titleRectImageAtRightForContentRect(contentRect: contentRect, titleRect: titleRect, imageRect: imageRect)
        break;
        case .top:
            titleRect = self.titleRectImageAtTopForContentRect(contentRect: contentRect, titleRect: titleRect, imageRect: imageRect)
        break
        case .bottom:
            titleRect = self.titleRectImageAtBottomForContentRect(contentRect: contentRect, titleRect: titleRect, imageRect: imageRect)
        break
        }
        return titleRect
    }
}

//MARK: - 设置图片的位置
extension IDButton {
    /// left
    fileprivate func imageRectImageAtLeftForContentRect(contentRect: CGRect, imageRect: CGRect, titleRect: CGRect) -> CGRect {
        var imageOrigin = imageRect.origin
        let imageSize = imageRect.size
        switch self.contentHorizontalAlignment {
        case .center: // 中心对齐
            // imageView的x值向左偏移间距的一半，另一半由titleLabe分担，不用管会不会超出contentRect，我定的规则是允许超出，如果对此作出限制，那么必须要对图片或者文字宽高有所压缩，压缩只能由imageEdgeInsets决定，当图片的内容区域容不下时才产生宽度压缩
            imageOrigin.x = imageOrigin.x - id_imageTitleSpace*0.5
            break
        case .right, .trailing:
            imageOrigin.x = imageOrigin.x - id_imageTitleSpace
            break
        case .fill: // 填充整个按钮,水平填充模式有点怪异，填充的意思是将图片和文字整个水平填满，但是，事实上能够被填满，但是titleLabel的x值不会发生变化，即图片被拉伸，但是图片的右边会预留一个titleLabel的宽度，这个titleLabel的宽度由系统计算，我们不必关心计算过程。还有，填充模式下，设置图片的contentMode是不管用的，因为系统强制设置了图片的大小
            imageOrigin.x = imageOrigin.x - id_imageTitleSpace*0.5
            break
        default: // 剩下的就是左对齐，左对齐image不用做任何改变
            break
        }
        return CGRect.init(origin: imageOrigin, size: imageSize)
    }
    fileprivate func titleRectImageAtLeftForContentRect(contentRect: CGRect, titleRect: CGRect, imageRect: CGRect) -> CGRect {
        var titleOrigin = titleRect.origin
        let titleSize = titleRect.size
        
        switch (self.contentHorizontalAlignment) {
        case .center:  // 中心对齐
            titleOrigin.x = titleOrigin.x + id_imageTitleSpace * 0.5
            break
        case .left, .leading:
            titleOrigin.x = titleOrigin.x + id_imageTitleSpace
            break
        case .fill: // 填充整个按钮
            // 填充整个按钮,水平填充模式有点怪异，填充的意思是将图片和文字整个水平填满，但是，事实上能够被填满，但是titleLabel的x值不会发生变化，即图片被拉伸，但是图片的右边会预留一个titleLabel的宽度，这个titleLabel的宽度由系统计算，我们不必关心计算过程。还有，填充模式下，设置图片的contentMode是不管用的，因为系统强制设置了图片的大小
            // 宽度减去间距的一半，另一半由imageView分担,x值保持系统值
            titleOrigin.x = titleOrigin.x + id_imageTitleSpace * 0.5
            break
        default: // 剩下的就是右对齐，右对齐titleLabel不用做任何改变
            break
        }
        return CGRect.init(origin: titleOrigin, size: titleSize)
    }
    /// right
    fileprivate func imageRectImageAtRightForContentRect(contentRect: CGRect, imageRect: CGRect, titleRect: CGRect) -> CGRect {
        let imageSafeWidth = contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right
        if (imageRect.size.width >= imageSafeWidth) {
            return imageRect
        }
        var imageOrigin = imageRect.origin
        var imageSize = imageRect.size
        var titleSize = titleRect.size
        // 这里水平中心对齐，跟图片在右边时的中心对齐时差别在于：图片在右边时中心对齐考虑了titleLabel+imageView这个整体，而这里只单独考虑imageView
        if (imageSize.width + titleSize.width > imageSafeWidth) {
            imageSize.width = imageSize.width - (imageSize.width + titleSize.width - imageSafeWidth);
        }
        
        let buttonWidth = contentRect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right
        titleSize = self.calculateTitleSizeForSystemTitleSize(titleSize: titleSize)
        switch self.contentHorizontalAlignment {
        case .center: // 中心对齐
            // (contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right - (imageSize.width + titleSize.width))/2.0+titleSize.width指的是imageView在其有效区域内联合titleLabel整体居中时的x值，有效区域指的是contentRect内缩imageEdgeInsets后的区域
            imageOrigin.x = (contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right - (imageSize.width + titleSize.width))/2.0 + titleSize.width + self.contentEdgeInsets.left + self.imageEdgeInsets.left + id_imageTitleSpace * 0.5
            break
        case .left, .leading:
            imageOrigin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left + titleSize.width + id_imageTitleSpace
            break
        case .right, .trailing:
            // 注意image的大小要使用系统计算的结果，这里不能使用self.currentImage.size.width，当imageEdgeInsets的left过大时可以进行测试
            imageOrigin.x = buttonWidth - imageSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right
            break
        case .fill:
            imageOrigin.x = buttonWidth - imageSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right + id_imageTitleSpace * 0.5
            break
        default:
            break
        }
        
        return CGRect.init(origin: imageOrigin, size: imageSize)
    }
    fileprivate func titleRectImageAtRightForContentRect(contentRect: CGRect, titleRect: CGRect, imageRect: CGRect) -> CGRect {
        var titleOrigin = titleRect.origin
        let titleSize = titleRect.size
        let imageSize = imageRect.size
        
        let buttonWidth = contentRect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right
        
        switch (self.contentHorizontalAlignment) {
        case .center: // 中心对齐
            // (contentRect.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right - (imageSize.width + titleSize.width))/2.0的意思是titleLabel在其有效区域内联合imageView整体居中时的x值，有效区域指的是contentRect内缩titleEdgeInsets后的区域
            titleOrigin.x = (contentRect.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right - (imageSize.width + titleSize.width))/2.0 + self.contentEdgeInsets.left + self.titleEdgeInsets.left - id_imageTitleSpace * 0.5
        case .leading, .left: // 左对齐
            titleOrigin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        case .right, .trailing: // 右对齐
            // 这里必须使用self.currentImage的宽度。不能使用imageSize.width，因为图片可能会被压缩或者拉伸，例如当图片的imageEdgeInsets的right设置过大，图片的宽度就会被压缩，这时的图片宽度不是我们要的
            let w = titleSize.width + (self.currentImage?.size.width ?? 0)
            let titlex = buttonWidth - w - self.titleEdgeInsets.right - self.contentEdgeInsets.right - self.id_imageTitleSpace
            titleOrigin.x = titlex
            break
        case .fill:
            let flag = titleSize.width + (self.currentImage?.size.width ?? 0)
            titleOrigin.x = buttonWidth - flag - self.titleEdgeInsets.right - self.contentEdgeInsets.right - id_imageTitleSpace * 0.5
            break
        }
        return CGRect.init(origin: titleOrigin, size: titleSize)
    }
    
    fileprivate func calculateTitleSizeForSystemTitleSize(titleSize: CGSize) -> CGSize {
        var myTitleSize = titleSize
        // 获取按钮里的titleLabel,之所以遍历获取而不直接调用self.titleLabel，是因为假如这里是第一次调用self.titleLabel，则会跟titleRectForContentRect: 方法造成死循环,titleLabel的getter方法中，alloc init之前调用了titleRectForContentRect:
        let titleLabel = self.findTitleLabel()
        if (titleLabel == nil) { // 此时还没有创建titleLabel，先通过系统button的字体进行文字宽度计算
            let fontSize = UIFont.buttonFontSize // 按钮默认字体，18号
            let dic = NSDictionary(object: UIFont.systemFont(ofSize: fontSize), forKey: NSAttributedString.Key.font as NSCopying)
            myTitleSize.height = ceil(self.currentTitle?.boundingRect(with: CGSize.init(width: titleSize.width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context:nil).size.height ?? 0)
            // 根据文字计算宽度，取上整，补齐误差，保证跟titleLabel.intrinsicContentSize.width一致
            myTitleSize.width = ceil(self.currentTitle?.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: titleSize.height), options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : AnyObject], context:nil).size.width ?? 0)
        } else {
            myTitleSize.width = titleLabel?.intrinsicContentSize.width ?? 0
            myTitleSize.height = titleLabel?.intrinsicContentSize.height ?? 0
        }
        return myTitleSize
    }
    // 遍历获取按钮里面的titleLabel
    func findTitleLabel() -> UILabel? {
        for subView in self.subviews {
            if subView.isKind(of: NSClassFromString("UIButtonLabel") ?? UILabel.classForCoder()) {
                let titleLabel = subView as? UILabel
                return titleLabel
            }
        }
        return nil
    }
    
    /// top
    fileprivate func titleRectImageAtTopForContentRect(contentRect: CGRect, titleRect: CGRect, imageRect: CGRect) -> CGRect {
        var titleOrigin = titleRect.origin
        var imageSize = self.currentImage?.size ?? CGSize.zero
        var titleSize = self.calculateTitleSizeForSystemTitleSize(titleSize: titleRect.size)
        
        let buttonWidth = contentRect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right
        let buttonHeight = contentRect.size.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom
        
        // 这个if语句的含义是：计算图片由于设置了contentEdgeInsets而被压缩的高度，设置imageEdgeInsets被压缩的高度不计算在内。这样做的目的是，当设置了contentEdgeInsets时，图片可能会被压缩，此时titleLabel的y值依赖于图片压缩后的高度，当设置了imageEdgeInsets时，图片也可能被压缩，此时titleLabel的y值依赖于图片压缩前的高度，这样以来，设置imageEdgeInsets就不会对titleLabel的y值产生影响
        if (imageSize.height + titleSize.height > contentRect.size.height) {
            imageSize.height = (self.currentImage?.size.height ?? 0) - ((self.currentImage?.size.height ?? 0) + titleSize.height - contentRect.size.height)
        }
        // titleLabel的安全宽度，这里一定要改变宽度值，因为当外界设置了titleEdgeInsets值时，系统计算出来的所有值都是在”左图右文“的基础上进行的，这个基础上可能会导致titleLabel的宽度被压缩，所以我们在此自己重新计算
        let titleSafeWidth = contentRect.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right
        if (titleSize.width > titleSafeWidth) {
            titleSize.width = titleSafeWidth
        }
        switch self.contentHorizontalAlignment {
        case .center:
            titleOrigin.x = (titleSafeWidth - titleSize.width) / 2.0 + self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        case .left, .leading:
            titleOrigin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        case .right, .trailing:
            titleOrigin.x = buttonWidth - titleSize.width - self.titleEdgeInsets.right - self.contentEdgeInsets.right
            break
        case .fill:
            titleOrigin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        default:
            break
        }
        if (titleSize.height > contentRect.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom) {
            titleSize.height = contentRect.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom
        }
        switch self.contentVerticalAlignment {
        case .center:
            // (imageSize.height + titleSize.height)这个整体高度很重要，这里相当于按照按钮原有规则进行对齐，即按钮的对齐方式不管是设置谁的Insets，计算时都是以图片+文字这个整体作为考虑对象
            titleOrigin.y =  (contentRect.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom - (imageSize.height + titleSize.height)) / 2.0 + imageSize.height + self.contentEdgeInsets.top + self.titleEdgeInsets.top + id_imageTitleSpace * 0.5
            break
        case .top:
            titleOrigin.y = self.contentEdgeInsets.top + self.titleEdgeInsets.top + imageSize.height + id_imageTitleSpace * 0.5
            break
        case .bottom:
            titleOrigin.y = buttonHeight - titleSize.height - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom + id_imageTitleSpace * 0.5
            break
        case .fill:
            titleOrigin.y = buttonHeight - titleSize.height - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom + id_imageTitleSpace * 0.5
            break
        default:
            break
        }
        return CGRect.init(origin: titleOrigin, size: titleSize)
    }
    /// top
    fileprivate func imageRectImageAtTopForContentRect(contentRect: CGRect, imageRect: CGRect, titleRect: CGRect) -> CGRect {
        var imageOrigin = imageRect.origin
        var imageSize = self.currentImage?.size ?? CGSize.zero
        let titleSize = self.calculateTitleSizeForSystemTitleSize(titleSize: titleRect.size)
        
        let imageSafeWidth = contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right
        let imageSafeHeight = contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom
        
        // 这里水平中心对齐，跟图片在右边时的中心对齐时差别在于：图片在右边时中心对齐考虑了titleLabel+imageView这个整体，而这里只单独考虑imageView
        if (imageSize.width > imageSafeWidth) {
            imageSize.width = imageSafeWidth
        }
        if (imageSize.height > imageSafeHeight) {
            imageSize.height = imageSafeHeight
        }
        
        let buttonWidth = contentRect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right
        let buttonHeight = contentRect.size.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom
        
        switch self.contentHorizontalAlignment {
        case .center:
            imageOrigin.x = (contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right - imageSize.width) / 2.0 + self.contentEdgeInsets.left + self.imageEdgeInsets.left
            break
        case .left, .leading:
            imageOrigin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left
            break
        case .right, .trailing:
            imageOrigin.x = buttonWidth - imageSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right
            break
        case .fill:
            imageOrigin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left
            imageSize.width = imageSafeWidth // 宽度填满
            break
        default:
            break
        }
        // 给图片高度作最大限制，超出限制对高度进行压缩，这样还可以保证titeLabel不会超出其有效区域
        let imageTitleLimitMaxH = contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom
        if (imageSize.height < imageTitleLimitMaxH) {
            if (titleSize.height + imageSize.height > imageTitleLimitMaxH) {
                let beyondValue = titleSize.height + (self.currentImage?.size.height ?? 0) - imageTitleLimitMaxH
                imageSize.height = imageSize.height - beyondValue
            }
        }
        switch self.contentVerticalAlignment {
        case .center:
            // (imageSize.height + titleSize.height)这个整体高度很重要，这里相当于按照按钮原有规则进行对齐，即按钮的对齐方式不管是设置谁的insets，计算时都是以图片+文字这个整体作为考虑对象
            imageOrigin.y =  (contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom - (imageSize.height + titleSize.height)) / 2.0 + self.contentEdgeInsets.top + self.imageEdgeInsets.top - id_imageTitleSpace * 0.5
            break
        case .top:
            imageOrigin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top - id_imageTitleSpace * 0.5
            break
        case .bottom:
            imageOrigin.y = buttonHeight - (imageSize.height + titleSize.height) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - id_imageTitleSpace * 0.5
            break
        case .fill:
            imageOrigin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top - id_imageTitleSpace * 0.5;
            imageSize.height = contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom - self.calculateTitleSizeForSystemTitleSize(titleSize: titleSize).height
            break
        default:
            break
        }
        return CGRect.init(origin: imageOrigin, size: imageSize)
    }
    
    /// bottom
    fileprivate func imageRectImageAtBottomForContentRect(contentRect: CGRect, imageRect: CGRect, titleRect: CGRect) -> CGRect {
        var imageOrigin = imageRect.origin
        var imageSize = self.currentImage?.size ?? CGSize.zero
        let titleSize = self.calculateTitleSizeForSystemTitleSize(titleSize: titleRect.size)
        
        let imageSafeWidth = contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right
        let imageSafeHeight = contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom
        
        // 这里水平中心对齐，跟图片在右边时的中心对齐时差别在于：图片在右边时中心对齐考虑了titleLabel+imageView这个整体，而这里只单独考虑imageView
        if (imageSize.width > imageSafeWidth) {
            imageSize.width = imageSafeWidth
        }
        if (imageSize.height > imageSafeHeight) {
            imageSize.height = imageSafeHeight
        }
        
        let buttonWidth = contentRect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right
        let buttonHeight = contentRect.size.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom
        
        switch self.contentHorizontalAlignment {
        case .center:
            imageOrigin.x = (contentRect.size.width - self.imageEdgeInsets.left - self.imageEdgeInsets.right - imageSize.width) / 2.0 + self.contentEdgeInsets.left + self.imageEdgeInsets.left
            break
        case .left, .leading:
            imageOrigin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left
            break
        case .right, .trailing:
            imageOrigin.x = buttonWidth - imageSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right
            break
        case .fill:
            imageOrigin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left
            imageSize.width = imageSafeWidth
            break
        default:
            break
        }
        // 给图片高度作最大限制，超出限制对高度进行压缩，这样还可以保证titeLabel不会超出其有效区域
        let imageTitleLimitMaxH = contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom
        if (imageSize.height < imageTitleLimitMaxH) {
            if (titleSize.height + imageSize.height > imageTitleLimitMaxH) {
                let beyondValue = titleSize.height + (self.currentImage?.size.height ?? 0) - imageTitleLimitMaxH
                imageSize.height = imageSize.height - beyondValue
            }
        }
        switch self.contentVerticalAlignment {
        case .center:
            // (self.currentImage.size.height + titleSize.height)这个整体高度很重要，这里相当于按照按钮原有规则进行对齐，即按钮的对齐方式不管是设置谁的insets，计算时都是以图片+文字这个整体作为考虑对象
            imageOrigin.y =  (contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom - (imageSize.height + titleSize.height)) / 2.0 + titleSize.height + self.contentEdgeInsets.top + self.imageEdgeInsets.top + id_imageTitleSpace * 0.5
            break
        case .top:
            imageOrigin.y = self.contentEdgeInsets.top + self.imageEdgeInsets.top + titleSize.height + id_imageTitleSpace * 0.5
            break
        case .bottom:
            imageOrigin.y = buttonHeight - imageSize.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom + id_imageTitleSpace * 0.5
            break
        case .fill:
            // 这里不能使用titleSize.height,因为垂直填充模式下，系统计算出的titleSize就是contentRect的高度，我们需要的是titleLabel拉伸前的高度
            imageOrigin.y = buttonHeight - imageSize.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom + id_imageTitleSpace * 0.5
            imageSize.height = contentRect.size.height - self.imageEdgeInsets.top - self.imageEdgeInsets.bottom - self.calculateTitleSizeForSystemTitleSize(titleSize: titleSize).height
            imageOrigin.y = buttonHeight - imageSize.height - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom + id_imageTitleSpace * 0.5
            break
        default:
            break
        }
        return CGRect.init(origin: imageOrigin, size: imageSize)
    }
    fileprivate func titleRectImageAtBottomForContentRect(contentRect: CGRect, titleRect: CGRect, imageRect: CGRect) -> CGRect {
        var titleOrigin = titleRect.origin
        var imageSize = self.currentImage?.size ?? CGSize.zero
        var titleSize = self.calculateTitleSizeForSystemTitleSize(titleSize: titleRect.size)
        
        // 这个if语句的含义是：计算图片由于设置了contentEdgeInsets而被压缩的高度，设置imageEdgeInsets被压缩的高度不计算在内。这样做的目的是，当设置了contentEdgeInsets时，图片可能会被压缩，此时titleLabel的y值依赖于图片压缩后的高度，当设置了imageEdgeInsets时，图片也可能被压缩，此时titleLabel的y值依赖于图片压缩前的高度，这样一来，设置imageEdgeInsets就不会对titleLabel的y值产生影响
        if ((self.currentImage?.size.height ?? 0) + titleSize.height > contentRect.size.height) {
            imageSize.height = (self.currentImage?.size.height ?? 0) - ((self.currentImage?.size.height ?? 0) + titleSize.height - contentRect.size.height)
        }
        
        // titleLabel的安全宽度，因为当外界设置了titleEdgeInsets值时，系统计算出来的所有值都是在”左图右文“的基础上进行的，这个基础上可能会导致titleLabel的宽度被压缩，所以我们在此自己重新计算
        let titleSafeWidth = contentRect.size.width - self.titleEdgeInsets.left - self.titleEdgeInsets.right
        if (titleSize.width > titleSafeWidth) {
            titleSize.width = titleSafeWidth
        }
        
        let buttonWidth = contentRect.size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right
        let buttonHeight = contentRect.size.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom
        
        // 水平方向
        switch (self.contentHorizontalAlignment) {
        case .center: // 中心对齐
            titleOrigin.x = (titleSafeWidth - titleSize.width) / 2.0 + self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        case .leading, .left: // 左对齐
            titleOrigin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        case .right, .trailing: // 右对齐
            titleOrigin.x = buttonWidth - titleSize.width - self.titleEdgeInsets.right - self.contentEdgeInsets.right
            break
        case .fill: // 填充
            titleOrigin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left
            break
        }
        
        if (titleSize.height > contentRect.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom) {
            titleSize.height = contentRect.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom
        }
        
        // 垂直方向
        switch (self.contentVerticalAlignment) {
        case .center: // 中心对齐
            // (self.currentImage.size.height + titleSize.height)这个整体高度很重要，这里相当于按照按钮原有规则进行对齐，即按钮的对齐方式不管是设置谁的Insets，计算时都是以图片+文字这个整体作为考虑对象
            titleOrigin.y =  (contentRect.size.height - self.titleEdgeInsets.top - self.titleEdgeInsets.bottom - (imageSize.height + titleSize.height)) / 2.0 + self.contentEdgeInsets.top + self.titleEdgeInsets.top - id_imageTitleSpace * 0.5
            break
        case .top: // 顶部对齐
            titleOrigin.y = self.contentEdgeInsets.top + self.titleEdgeInsets.top - id_imageTitleSpace * 0.5
            break
        case .bottom: // 底部对齐
            titleOrigin.y = buttonHeight - (titleSize.height + imageSize.height) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - id_imageTitleSpace * 0.5
            break
        case .fill: // 填充
            titleOrigin.y = self.contentEdgeInsets.top + self.titleEdgeInsets.top - id_imageTitleSpace * 0.5
            break
        }
        
        return CGRect.init(origin: titleOrigin, size: titleSize)
    }
}
