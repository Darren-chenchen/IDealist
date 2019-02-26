//
//  HDTabbarViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/11/30.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

open class IDTabbarViewController: UITabBarController {

    // 主界面点击手势，用于在菜单划出状态下点击主页后自动关闭菜单
    var tapGesture: UITapGestureRecognizer!
    // 首页中间的主要视图的来源
    var mainViewController: UIViewController!
    // 侧滑菜单视图的来源
    var menuViewController: UIViewController?
    let transitionW: CGFloat = 80
    let alpheValue:CGFloat = 0.6
    
    lazy var menuCoverView: UIView = {
        let viewCover = UIView.init(frame: self.menuViewController?.view.bounds ?? CGRect.zero)
        viewCover.backgroundColor = UIColor.black
        return viewCover
    }()
    lazy var mainCoverView: UIView = {
        let viewCover = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
        viewCover.backgroundColor = UIColor.black
        return viewCover
    }()

    
    public var id_titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -5)

    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func id_setupChildViewController(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?, title: NSString) {
        
        let navVC = IDBaseNavViewController.init(rootViewController: viewController)
        
        // 让图片显示图片原始颜色  “UIImage” 后+ “.imageWithRenderingMode(.AlwaysOriginal)”
        navVC.tabBarItem = UITabBarItem.init(title: title as String, image: image, selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
        navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        
        // 修改标题和图片间距
        navVC.tabBarItem.titlePositionAdjustment = id_titlePositionAdjustment
        self.addChild(navVC)
    }
    
    /// 初始化侧滑
    public func id_setupSlider(mainVC: UIViewController, sliderVC: UIViewController) {
        self.menuViewController = sliderVC
        self.setupLeftView()
        self.setupLeftSlider(mainVC: mainVC)
    }
    /// 展示侧滑
    public func id_showSliderView() {
        self.clickLeftBtnForLeftSliderView()
    }
    /// 关闭侧滑
    public func id_dismissSliderView() {
        self.hiddenMenuVC()
    }
}

extension IDTabbarViewController {
    
    func setupLeftView() {
        self.menuViewController?.view.xf_x = -KScreenWidth
        self.menuViewController?.view.xf_y = 0
        self.view.addSubview(menuViewController?.view ?? UIView())
        
        self.menuCoverView.alpha = self.alpheValue
        self.menuViewController?.view.addSubview(self.menuCoverView)
    }
    func setupLeftSlider(mainVC: UIViewController) {

        self.mainViewController = mainVC
        
        self.mainCoverView.isHidden = true
        self.mainCoverView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self.mainCoverView)
        UIApplication.shared.keyWindow?.bringSubviewToFront(self.mainCoverView)
        
        // 给主视图绑定 UIPanGestureRecognizer
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.coverpan(pan:)))
        mainViewController.view.addGestureRecognizer(panGesture)
        // 生成单击收起菜单手势
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hiddenMenuVC))
        self.mainCoverView.addGestureRecognizer(tapGesture)
        
        self.mainCoverView.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(self.CoverViewpan(pan:))))
    }
    @objc func CoverViewpan(pan:UIPanGestureRecognizer) {
        
        let point = pan.translation(in: self.mainCoverView)
        
        let offSetX = point.x   // x<0是左拽
        
        if offSetX<0 {
            
            self.mainViewController.navigationController?.view.xf_x = KScreenWidth-self.transitionW+offSetX
            self.tabBar.xf_x = KScreenWidth-self.transitionW+offSetX
            self.menuViewController?.view.xf_x = offSetX + (-self.transitionW)
            self.mainCoverView.xf_x = self.tabBar.xf_x
            
            
            self.menuCoverView.alpha = self.alpheValue * (-offSetX/(KScreenWidth-transitionW))
            self.mainCoverView.alpha = self.alpheValue - self.menuCoverView.alpha
            
            // 停止拖拽，判断位置
            if (pan.state == UIGestureRecognizer.State.ended) {
                if (-offSetX)>KScreenWidth*0.5-80 {  // 超过了屏幕的一半
                    self.hiddenMenuVC()
                } else {
                    self.showMenuVC()
                }
            }
        }
        
    }
    
    func addCover() {
        self.mainCoverView.isHidden = false
    }
    
    // 拖拽
    @objc private func coverpan(pan:UIPanGestureRecognizer){
        
        let point = pan.translation(in: self.mainViewController.view)
        
        let offSetX = point.x   // x<0是左拽
        
        if offSetX<=0 {
            
        } else {
            
            self.addCover()
            
            self.mainViewController.navigationController?.view.xf_x = offSetX
            self.tabBar.xf_x = offSetX
            self.menuViewController?.view.xf_x = -KScreenWidth+offSetX
            self.mainCoverView.xf_x = self.tabBar.xf_x
            
            self.menuCoverView.alpha = self.alpheValue - self.alpheValue * (offSetX/(KScreenWidth-self.transitionW))
            self.mainCoverView.alpha = self.alpheValue - self.menuCoverView.alpha
            
            // 停止拖拽，判断位置
            if (pan.state == UIGestureRecognizer.State.ended) {
                if (offSetX)>KScreenWidth*0.5-80 {  // 超过了屏幕的一半
                    self.showMenuVC()
                } else {
                    self.hiddenMenuVC()
                }
                
            }
        }
    }
    
    func showMenuVC() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.mainViewController.navigationController?.view.xf_x = KScreenWidth-self.transitionW
            self.tabBar.xf_x = KScreenWidth-self.transitionW
            self.mainCoverView.xf_x = self.tabBar.xf_x
            
            self.menuViewController?.view.xf_x = -self.transitionW
            
            self.menuCoverView.alpha = 0
            self.mainCoverView.isHidden = false
            self.mainCoverView.alpha = self.alpheValue
            
        }) { (com) in
        }
    }
    
    @objc func hiddenMenuVC () {
        UIView.animate(withDuration: 0.2, animations: {
            
            self.mainViewController.navigationController?.view.xf_x = 0
            self.tabBar.xf_x = 0
            self.mainCoverView.xf_x = 0
            
            self.menuViewController?.view.xf_x = -KScreenWidth
            
            self.menuCoverView.alpha = self.alpheValue
            self.mainCoverView.isHidden = true
            self.mainCoverView.alpha = 0
        }) { (com) in
            self.mainCoverView.isHidden = true
        }
    }
    
    func clickLeftBtnForLeftSliderView() {
        self.addCover()
        self.showMenuVC()
    }
}

extension UIView {
    /// x
    var xf_x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    /// y
    var xf_y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var xf_height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var xf_width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var xf_size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var xf_centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var xf_centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
}
