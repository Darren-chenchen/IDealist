//
//  IDSelectView.swift
//  IDUIKit-ios
//
//  Created by darren on 2018/12/11.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
import JXSegmentedView

public typealias IDSelectViewTitleClickClosure = (Int) -> Void

public enum IDSelectViewType {
    case normal  // JXSegmentedTitleDataSource
    case number  // JXSegmentedNumberDataSource
    case dots    // JXSegmentedDotDataSource
}

public enum IDSelectViewIndicatorType {
    case line
    case ellipse
}

open class IDSelectView: UIView {
    
    let segmentedView = JXSegmentedView()
    
    var segmentedDataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    let numberDataSource = JXSegmentedNumberDataSource()
    let dotsDataSource = JXSegmentedDotDataSource()

    let indicator = JXSegmentedIndicatorLineView()
    let ellipseIndicator = JXSegmentedIndicatorBackgroundView()
    
    public var titleClickClosure: IDSelectViewTitleClickClosure?
    open var numberStringFormatterClosure: ((Int) -> String)?

    /// 初始化类型
    public var id_type: IDSelectViewType = IDSelectViewType.normal {
        didSet {
            if id_type == .normal {
                self.setupNormalType()
            }
            if id_type == .number {
                self.setupNumberType()
            }
            if id_type == .dots {
                self.setupDotType()
            }
        }
    }
    
    /// 标题数组
    public var id_titles: [String]? {
        didSet {
            segmentedDataSource.titles = id_titles ?? []
            numberDataSource.titles = id_titles ?? []
            dotsDataSource.titles = id_titles ?? []
            //reloadData(selectedIndex:)一定要调用
            segmentedDataSource.reloadData(selectedIndex: 0)
            if self.id_type == .number {
                self.updateNumberType()
            }
        }
    }
    /// 指示器宽度
    public var id_indicatorWidth: CGFloat? {
        didSet {
            
            if self.id_indicatorType == .line {
                indicator.indicatorWidth = id_indicatorWidth ?? JXSegmentedViewAutomaticDimension
                segmentedView.indicators = [indicator]
            }
            
            if self.id_indicatorType == .ellipse {
                ellipseIndicator.indicatorWidth = id_indicatorWidth ?? JXSegmentedViewAutomaticDimension
                segmentedView.indicators = [ellipseIndicator]
            }
        }
    }
    
    /// 指示器与内容同宽
    public var id_indicatorEqualWidth: Bool? {
        didSet {
            if id_indicatorEqualWidth == true {
                if self.id_indicatorType == .line {
                    indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
                    segmentedView.indicators = [indicator]
                }
               
                if self.id_indicatorType == .ellipse {
                    ellipseIndicator.indicatorWidth = JXSegmentedViewAutomaticDimension
                    segmentedView.indicators = [ellipseIndicator]
                }
            }
        }
    }
    /// 指示器的颜色
    public var id_indicatorColor: UIColor = IDealistConfig.share.mainColor {
        didSet {
            indicator.indicatorColor = id_indicatorColor
            ellipseIndicator.indicatorColor = id_indicatorColor
        }
    }

    /// 当前选中的index，也可以设置index
    public var id_currentIndex: Int {
        get {
            return self.segmentedView.selectedIndex
        }
        set {
            self.segmentedView.selectItemAt(index: newValue)
        }
    }
    
    /// item之前的间距
    public var id_itemSpacing: CGFloat? {
        didSet {
            self.segmentedDataSource.itemSpacing = id_itemSpacing ?? 20
        }
    }
    /// 每一项的宽度
    public var id_itemContentWidth: CGFloat? {
        didSet {
            self.segmentedDataSource.itemContentWidth = id_itemContentWidth ?? JXSegmentedViewAutomaticDimension
        }
    }
    
    /// 标题展示几行,需要固定宽度
    public var id_titleNumberOfLines: Int? {
        didSet {
            self.segmentedDataSource.itemContentWidth = self.id_itemContentWidth ?? 50
            self.segmentedDataSource.titleNumberOfLines = id_titleNumberOfLines ?? 1
            segmentedDataSource.reloadData(selectedIndex: 0)
            
            self.numberDataSource.itemContentWidth = self.id_itemContentWidth ?? 50
            self.numberDataSource.titleNumberOfLines = id_titleNumberOfLines ?? 1
            self.updateNumberType()
            
            self.dotsDataSource.itemContentWidth = self.id_itemContentWidth ?? 50
            self.dotsDataSource.titleNumberOfLines = id_titleNumberOfLines ?? 1
            self.updateDotsType()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.segmentedView.reloadData()
            }
        }
    }
    /// 非选中状态的颜色
    public var id_titleNormalColor: UIColor = UIColor.black {
        didSet {
            self.segmentedDataSource.titleNormalColor = id_titleNormalColor
            segmentedDataSource.reloadData(selectedIndex: 0)
            
            self.numberDataSource.titleNormalColor = id_titleNormalColor
            self.updateNumberType()
            
            self.dotsDataSource.titleNormalColor = id_titleNormalColor
            self.updateDotsType()
        }
    }
    /// 选中状态的颜色
    public var id_titleSelectedColor: UIColor = IDealistConfig.share.mainColor {
        didSet {
            self.segmentedDataSource.titleSelectedColor = id_titleSelectedColor
            segmentedDataSource.reloadData(selectedIndex: 0)
            
            self.numberDataSource.titleSelectedColor = id_titleSelectedColor
            self.updateNumberType()
            
            self.dotsDataSource.titleSelectedColor = id_titleSelectedColor
            self.updateDotsType()
        }
    }
    /// 非选中状态的字体
    public var id_titleNormalFont: UIFont? {
        didSet {
            self.segmentedDataSource.titleNormalFont = id_titleNormalFont ?? UIFont.systemFont(ofSize: 15)
            segmentedDataSource.reloadData(selectedIndex: 0)
            
            self.numberDataSource.titleNormalFont = id_titleNormalFont ?? UIFont.systemFont(ofSize: 15)
            self.updateNumberType()
            
            self.dotsDataSource.titleNormalFont = id_titleNormalFont ?? UIFont.systemFont(ofSize: 15)
            self.updateDotsType()
        }
    }
    /// 选中状态的字体
    public var id_titleSelectedFont: UIFont? {
        didSet {
            self.segmentedDataSource.titleSelectedFont = id_titleSelectedFont
            segmentedDataSource.reloadData(selectedIndex: 0)
            
            self.numberDataSource.titleSelectedFont = id_titleSelectedFont
            self.updateNumberType()
            
            self.dotsDataSource.titleSelectedFont = id_titleSelectedFont ?? UIFont.systemFont(ofSize: 15)
            self.updateDotsType()
        }
    }
    /// 指示器的类型，横线、椭圆
    public var id_indicatorType: IDSelectViewIndicatorType = .line {
        didSet {
            if id_indicatorType == .line {
                indicator.indicatorWidth = id_indicatorWidth ?? JXSegmentedViewAutomaticDimension
                segmentedView.indicators = [indicator]
            }
            if id_indicatorType == .ellipse {
                ellipseIndicator.indicatorHeight = 30
                segmentedView.indicators = [ellipseIndicator]
            }
        }
    }
    /// 椭圆指示器的高度
    public var id_ellipseIndicatorHeight: CGFloat = 30 {
        didSet {
            ellipseIndicator.indicatorHeight = id_ellipseIndicatorHeight
        }
    }
    
    /// 数字数字，个数和titles对应
    public var id_numbers: [Int] = [] {
        didSet {
            numberDataSource.numbers = id_numbers
            self.updateNumberType()
            // number每次更新都更新视图
           self.id_reloadData()
        }
    }
    
    open var id_numberBackgroundColor: UIColor = .red {
        didSet {
            self.numberDataSource.numberBackgroundColor = id_numberBackgroundColor
            self.updateNumberType()
        }
    }
    /// numberLabel的textColor
    open var id_numberTextColor: UIColor = .white {
        didSet {
            self.numberDataSource.numberTextColor = id_numberTextColor
            self.updateNumberType()
        }
    }
    /// numberLabel的font
    open var id_numberFont: UIFont = UIFont.systemFont(ofSize: 11) {
        didSet {
            self.numberDataSource.numberFont = id_numberFont
            self.updateNumberType()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.updateNumberType()
            }
        }
    }
    /// numberLabel的默认位置是center在titleLabel的右上角，可以通过numberOffset控制X、Y轴的偏移
    open var id_numberOffset: CGPoint = CGPoint.zero {
        didSet {
            self.numberDataSource.numberOffset = id_numberOffset
            self.updateNumberType()
        }
    }
    
    /// 红色的提示，需要展示哪个就设置true
    public var id_dotStates: [Bool] = [] {
        didSet {
            dotsDataSource.dotStates = id_dotStates
            //reloadData(selectedIndex:)一定要调用
            dotsDataSource.reloadData(selectedIndex: self.id_currentIndex)
            self.id_reloadData()
        }
    }
    /// 红点的size
    open var id_dotSize = CGSize(width: 10, height: 10) {
        didSet {
            dotsDataSource.dotSize = id_dotSize
            self.updateDotsType()
        }
    }
    /// 红点的圆角值，JXSegmentedViewAutomaticDimension等于dotSize.height/2
    open var id_dotCornerRadius: CGFloat = JXSegmentedViewAutomaticDimension {
        didSet {
            dotsDataSource.dotCornerRadius = id_dotCornerRadius
            self.updateDotsType()
        }
    }
    /// 红点的颜色
    open var id_dotColor = IDealistConfig.share.mainColor {
        didSet {
            dotsDataSource.dotColor = id_dotColor
            self.updateDotsType()
        }
    }
    /// dotView的默认位置是center在titleLabel的右上角，可以通过dotOffset控制X、Y轴的偏移
    open var id_dotOffset: CGPoint = CGPoint.zero {
        didSet {
            dotsDataSource.dotOffset = id_dotOffset
            self.updateDotsType()
        }
    }

    
    // 初始化
    public override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.white
        
        segmentedDataSource.isTitleColorGradientEnabled = true
        numberDataSource.isTitleColorGradientEnabled = true
        dotsDataSource.isTitleColorGradientEnabled = true

        /// 初始化设置
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        segmentedView.indicators = [indicator]
        segmentedView.dataSource = segmentedDataSource

        segmentedView.delegate = self
        segmentedView.frame = self.bounds
        self.addSubview(self.segmentedView)
        
        // 初始化颜色
        self.dotsDataSource.dotColor = IDealistConfig.share.mainColor
        self.dotsDataSource.titleSelectedColor = IDealistConfig.share.mainColor

        self.numberDataSource.titleSelectedColor = IDealistConfig.share.mainColor
        self.numberDataSource.numberBackgroundColor = IDealistConfig.share.mainColor

        self.segmentedDataSource.titleSelectedColor = IDealistConfig.share.mainColor
        
        self.indicator.indicatorColor = IDealistConfig.share.mainColor
        self.ellipseIndicator.indicatorColor = IDealistConfig.share.mainColor

        self.initEventHendle()
    }
    
    public func id_reloadData() {
        segmentedView.reloadData()
    }
    
    func setupNormalType() {
        segmentedView.dataSource = segmentedDataSource
    }
    func setupNumberType() {
        segmentedView.dataSource = numberDataSource
        numberDataSource.numberStringFormatterClosure = self.numberStringFormatterClosure
    }
    func setupDotType() {
        segmentedView.dataSource = dotsDataSource
    }
    // 刷新JXSegmentedNumberDataSource类型的视图
    func updateNumberType() {
        if self.id_numbers.count < (self.id_titles?.count ?? 0) {
            if self.id_type == .number {
                print("id_numbers的数组个数需要和id_titles的数组个数保持一致")
            }
            return
        }
        numberDataSource.reloadData(selectedIndex: self.segmentedView.selectedIndex)
    }
    // 刷新dot类型
    func updateDotsType() {
        if self.id_dotStates.count < (self.id_titles?.count ?? 0) {
            if self.id_type == .dots {
                print("id_dotStates的数组个数需要和id_titles的数组个数保持一致")
            }
            return
        }
        dotsDataSource.reloadData(selectedIndex: self.segmentedView.selectedIndex)
    }
    
    func initEventHendle() {
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension IDSelectView: JXSegmentedViewDelegate {
    public func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        print("didSelectedItemAt===\(index)")
        if self.titleClickClosure != nil {
            self.titleClickClosure!(index)
        }
    }
    
    public func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
    }
    
    public func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
    }
}
