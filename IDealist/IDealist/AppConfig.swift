
import UIKit

/// 屏幕宽度
var KScreenHeight = UIScreen.main.bounds.height
/// 屏幕高度
var KScreenWidth = UIScreen.main.bounds.width
/// 屏幕比例
var kScale = UIScreen.main.scale
/// 导航栏高度+状态栏(iphonex 88)
var KNavgationBarHeight: CGFloat = UIDevice.id_isX() == true ? 88:64
/// tabbar高度(iphonex 83)
var KTabBarHeight: CGFloat = UIDevice.id_isX() == true ? 83:49
/// iphonex 底部间距
var IphoneXBottomSpace: CGFloat = UIDevice.id_isX() == true ? 34:0


var dialogWidth: CGFloat = 300

var RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

// MARK:- 设置圆角
func HDViewsBorder(_ view:UIView, borderWidth:CGFloat, borderColor:UIColor?=nil,cornerRadius:CGFloat){
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor?.cgColor
    view.layer.cornerRadius = cornerRadius
    view.layer.masksToBounds = true
}

let HDWindow = UIApplication.shared.keyWindow
let HDNotificationCenter = NotificationCenter.default
let HDUserDefaults = UserDefaults.standard
