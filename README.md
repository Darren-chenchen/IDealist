## IDealist框架-IOS常用框架集合

![Pod Version](https://img.shields.io/cocoapods/v/IDealist.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/IDealist.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/IDealist.svg?style=flat)

<a style="font-size: 20px" href="https://www.jianshu.com/p/de390c583d0b" target="_blank">部分截图</a>


# 要求

- iOS 8.0+
- swift 3.0+

# 安装方式
- 使用 CocoaPods

```
pod 'IDealist'
```

###### 设置所有组件的主题色

```
IDealistConfig.share.id_setupMainColor(color: UIColor.red)
```
# 项目中引用IDeal框架

#### 引用IDealist内部的框架有2种方法
> 1.按需导入，每个文件中需要哪个框架就引用哪个，例如：import IDealist。
> 
> 优点：有提示。缺点：需要每次都导入

-

> 2.使用 @_exported 关键字导入一次即可。例如：`@_exported import IDealist`
> 
> 优点：只要导入一次，缺点：可能没有代码提示

注意：对于IDealist框架，其内部含有很多扩展方法，需要使用`@_exported import IDealist`的方式导入一次即可，也有代码提示。

# 使用详解

# IDToast

调用id_show方法，可传入参数介绍如下

```
// 默认纯文本、展示在window上、1.5秒消失、中间位置
// onView: 可以指定显示在指定的view上
// success=nil,展示纯文本，success=false展示错误的图片，success=true展示成功的图片
// position: 展示的位置IDToastPosition.top、IDToastPosition.middle、IDToastPosition.bottom
id_show(msg: String, onView:UIView? = nil,success: IDToastUtilsImageType? = nil,duration:CGFloat? = nil, position: IDToastPosition? = .middle)
```

使用方式

```
IDToast.id_show(msg: "展示纯文本")
IDToast.id_show(msg: "展示纯文本，在指定view上。指定3s", onView: self.view, duration: 3)
IDToast.id_show(msg: "登录成功", success: IDToastUtilsImageType.success)

```

修改toast样式

```
IDToastManager.share.successImage = UIImage(named: "message_success")
IDToastManager.share.textFont = UIFont.boldSystemFont(ofSize: 20)
IDToastManager.share.textColor = UIColor.red
IDToastManager.share.bgColor = UIColor(white: 0, alpha: 0.5)
IDToastManager.share.cornerRadius = 8
```

##### 使用注意

1.IDToast 默认是支持多任务顺序异步执行的，如果连续调用多次id_show,toast会依次执行。通过以下属性可控制该功能

```
IDToastManager.share.supportQuene = false
```

2.修改toast样式是通过单例来设置的，所以建议在项目初始化时就统一toast的样式。
	
---

# IDDialog

目前提供4种类型的弹框

##### 1.普通弹框，调用id_show方法

```
IDDialog.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "确定", rightActionTitle: "取消", leftHandler: {
}) {
}
```

##### 2.带有图片显示的弹框，调用id_showImg方法

```
IDDialog.id_showImg(success: IDDialogUtilImageType.success, msg: "提交成功", leftActionTitle: "知道了", rightActionTitle: nil, leftHandler: nil, rightHandler: nil)

```

##### 3.带有输入文本框的弹框，调用id_showInput方法

```
IDDialog.id_showInput(msg: "请输入取消原因", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
   print(text)
}) { (text) in
   print(text)
}

```
##### 4.自定义内容的弹框，调用id_showCustom方法
```
IDDialog.id_showCustom(msg: "标题", leftActionTitle: nil, rightActionTitle: "确定", customView: self.myView, leftHandler: { (customView) in

}) { (customView) in

}

```

属性介绍

```
/// 内容的对齐方式
public var textAlignment = NSTextAlignment.center
/// 设置主题色，2个按钮时只设置右边的主题色，1个按钮时显示主题色
public var mainColor = UIColor.black
/// 是否支持动画
public var supportAnimate = true
/// 自定义动画
public var animate = CABasicAnimation()
/// 成功图片
public var successImage = UIImage(named: "ic_toast_success", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
/// 失败图片
public var failImage = UIImage(named: "icn_icn_fail", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
/// 警告图片
public var warnImage = UIImage(named: "icon_sign", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
/// 针对输入框类型的弹框，限制输入框的输入条件,文本框默认没有限制，在文本框消失时，自动重置文本框的属性
/// 最多允许输入多少个字符
public var maxLength: Int?
/// 只允许输入数字和小数点
public var onlyNumberAndPoint: Bool?
/// 设置小数点位数
public var pointLength: Int?
/// 只允许输入数字
public var onlyNumber: Bool?
/// 禁止输入表情符号emoji
public var allowEmoji: Bool?
/// 正则表达式
public var predicateString: String?
```

---
# IDLoading

##### loading的类型

```
public enum IDLoadingUtilLoadingType {
    case wait  // 会阻止用户交互， 需要等待加载完成
    case nav // 一条进度线条
    case free // 不会阻止用户交互
}
```

##### 1.展示不阻止用户交互的加载框

```
 IDLoading.id_show()
 IDLoading.id_dismiss()  // 取消

```

##### 2.展示阻止用户交互的加载框

```
 IDLoading.id_showWithWait()
 IDLoading.id_dismissWait()

```

##### 3.展示网页加载进度

```
 IDLoading.id_showProgressLine(onView: self.navView)
 IDLoading.id_dismissNav()

```

##### 4.自定义gif动画

```
 IDLoading.id_showGif(gifName: nil, type: IDLoadingUtilLoadingType.free, onView: self.view)
 IDLoading.id_dismissGif()
```

##### 5.定制网页加载进度条的颜色
```
IDLoading.id_showProgressLine(onView: self.navView, colors: [RGBAColor(0, 238, 0, 0.1).cgColor, RGBAColor(0, 238, 0, 0.5).cgColor, RGBAColor(0, 238, 0, 1).cgColor])

```

---


# IDImagePicker
##### 1.访问相册，外部弹出

```
let picker = IDImagePicker()
picker.cameraOut = true
picker.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
}
```

##### 2.访问相册，默认多选

```
let picker = IDImagePicker()
picker.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
}
```

##### 3.访问相册，单选

```
let picker = IDImagePicker()
picker.singleImageChooseType = .singlePicture
picker.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
}

```
##### 4.高度定制导航栏颜色

```
let picker = IDImagePicker()
picker.navColor = UIColor.purple
picker.navTitleColor = UIColor.white
picker.statusBarType = .white
picker.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
}
```
##### 5.高度定制主题色

```
let picker = IDImagePicker()
picker.tineColor = UIColor.green
picker.id_setupImagePickerWith(maxImagesCount: 10) { (assrtArr, img) in
}

```

---

# IDScanCode

二维码与条形码扫描控件，而且能够实现快速的扫描二维码和条形码

1.使用方法

新建控制器继承IDScanCodeController即可

2.可定制的一些提示语

```
id_scanTitle // 扫描框顶部的提示语，默认无
id_scanDetailTitle // 扫描框底部的提示语，默认是“将二维码/条码放入框内，即可自动扫描”
```

----

# IDEmptyView

> 使用
>IDEmptyView 扩展了UIView，可以通过id_empty属性添加到目标视图
>当你需要展示或隐藏的时候可以利用rxcocoa的扩展绑定数据和isHidden属性

```Swift
view.id_empty = IDEmptyView.create().configStyle(style)
```

> 创建并使用

```Swift
let emptyView = IDEmptyView.create().configStyle(style)
view.addSubview(emptyView)
```

>  style 可设置为

```Swift
public enum Style {
    case normal
    //有为什么为空状态说明
    case normalDeail(String)
    //可操作空状态
    case normalOperational
    //可操作并有说明的空状态
    case normalDetailOperational(String)
    //网络加载失败可操作
    case load
    //网络环境不良可操作
    case loadDetail
    // 空状态的文字提示
    case detail(String)
}
```
> 当你的style 为 normalOperational，normalDetailOperational，load，loadDetail时
> 必须设置操作回调

```Swift
emptyView.setOperatorAction { /// 重新加载页面或者做其他事 }
///也可以在创建的时候设置
let emptyView = IDEmptyView.create().configStyle(style).setOperatorAction {}
view.addSubview(emptyView)
```

> 自定义图片，文本，按钮文字

```Swift
 emptyView.custom(image, title, detail, buttonText)
```

---

# IDUIKit

### 1.IDButton

> 封装IDButton的原因：解决Button的图片位置问题。当系统的Button的宽度自适应并且Button的样式是文字和图片的结合，图片可以在顶部，右侧，底部，此时如果使用imageEdgeInsets和titleEdgeInsets是达不到理想效果的，IDButton由此产生。IDButton继承自系统的Button。

> 按钮的类型

```
public enum IDButtonType {
    case normal
    case primary
    case error
    case loading
}

normal:
      self.layer.borderWidth = 1
      self.setTitleColor(UIColor.black, for: UIControl.State.normal)
      self.backgroundColor = UIColor.white
      
primary: // 背景色是主题色
       self.backgroundColor = ColorConfig.share.mainColor
       self.layer.borderWidth = 0
       self.setTitleColor(UIColor.white, for: UIControl.State.normal)

error:   // 背景色是红色
       self.backgroundColor = RGBAColor(233, 80, 79, 1) // 写死的颜色
       self.layer.borderWidth = 0
       self.setTitleColor(UIColor.white, for: UIControl.State.normal)

loading: // 可以展示一个loading动画
		self.id_startLoading() // 开始动画
		self.id_stopLoading()  // 结束动画
```

> 按钮图片的位置

```
public enum IDButtonPosition {
    case left     // 图片在文字左侧
    case right    // 图片在文字右侧
    case top      // 图片在文字上侧
    case bottom   // 图片在文字下侧
}
```
> 设置按钮渐变色

```
public enum IDButtonGradientDirection {
    case horizontally
    case vertically
}

public func id_setupGradient(gradientColors: [UIColor], gradientDirection direction: IDButtonGradientDirection, gradientFrame: CGRect? = nil) {
	....
}
```

> 部分属性

```
/// 图片位置
open var id_imagePosition = IDButtonPosition.left
/// 图片和文字之间的间距
open var id_imageTitleSpace: CGFloat = 0 
/// loading视图和文字之间的间距
open var id_loadingTitleSpace: CGFloat = 5 
/// 按钮类型
open var id_type: IDButtonType = .normal
/// 加载框大小
open var id_loadingSize: CGSize = CGSize.init(width: 15, height: 15)
```

---

### 2.IDLabel

> 开启长按复制功能

```
label.id_canCopy = true
```

> 富文本：图片插入的文字的指定位置

```
label.id_setupAttbutImage(img: UIImage(named: "ic_new")!, index: 0)
```

---

### 3.IDTextView

> 部分属性

```
/// 占位文字
public var id_placehoder: String? 
public var id_placehoderColor: UIColor? 
/// 文字改变的回调
public var textChangeClouse: IDTextViewTextDidChangedClouse?
/// 最多允许输入多少个字符
public var id_maxLength: Int?
/// 只允许输入数字和小数点
public var id_onlyNumberAndPoint: Bool?
/// 设置小数点位数
public var id_pointLength: Int?
/// 只允许输入数字
public var id_onlyNumber: Bool?
/// 禁止输入表情符号emoji
public var id_allowEmoji: Bool?
/// 正则表达式
public var id_predicateString: String?
/// 是否支持文本高度跟随内容变化而变化
public var id_supportAutoHeight = false

```

### 4.IDPopView

> 为了达到高度定制内容的需求，IDPopView只提供了一个盛放内容的容器，容器内的具体内容是需要外界传入的。
> 基本使用如下

```
/// self.contentView 是一个外界UIView
let pop = IDPopView.init(contentView: self.contentView)
/// 箭头的位置IDPopViewArrowPosition.left、center、right、custom
pop.id_arrowPosition = .left
/// 箭头的位置
pop.id_trianglePoint = CGPoint.init(x: KScreenWidth-30, y: 120)
/// popview展示在的具体的位置
pop.showInRect(rect: CGRect.init(x: KScreenWidth-160-10, y: 128, width: 160, height: self.contentView.frame.height + 16))
```

### 5.IDProgressView

> IDProgressView继承自UIProgressView，初始化的时候设置了主题色
> 
> IDProgressCircleView展示的是圆形进度条、饼图进度条。部分属性：

```
/// value的范围是0-100
public var id_value: CGFloat = 0 
/// 默认是2
public var id_lineWidth: CGFloat = 2
    
/// 颜色
public var id_fillColor: UIColor = (ColorConfig.share.mainColor ?? UIColor.white)
/// 类型 .circle、.pie
public var id_type: IDProgressCircleViewType = .circle 
```

### 6.IDSearchBar

> IDSearchBar的样式参考蓝湖
> 
> 部分属性如下

    /// 占位文字
    public var id_placeHolder: String = "请输入搜索关键字"
    /// 搜索图片
    public var id_searchImage: UIImage? = UIImage(named: "ic_ssearch", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    /// 搜索框背景颜色
    public var id_textFieldBgColor = UIColor.white
    /// 搜索框字体大小
    public var id_textFieldFont = UIFont.systemFont(ofSize: 12) 
    /// 右边按钮的文字
    public var id_cancelButtonTitle = "取消" 
    /// 右边按钮的文字颜色
    public var id_cancelButtonTitleColor = RGBAColor(95,95,95,1) 
    /// 右边按钮的文字字体
    public var id_cancelButtonTitleFont = UIFont.systemFont(ofSize: 13) 
    /// 是否显示右边的按钮
    public var id_showRightBtn = false 
    /// 搜索容器的背景色
    public var id_containerBgColor = RGBAColor(239, 239, 244, 1) 
    /// 搜索框的圆角大小
    public var id_cornerRadius: CGFloat = 2 


### 7.IDSwitch

> IDSwitch继承自UIControl， 默认宽80，高度40

 
### 8.IDTextField

>部分属性

    /// 最多允许输入多少个字符
    public var maxLength: Int?
    /// 只允许输入数字和小数点
    public var onlyNumberAndPoint: Bool?
    /// 设置小数点位数
    public var pointLength: Int?
    /// 只允许输入数字
    public var onlyNumber: Bool?
    /// 禁止输入表情符号emoji
    public var allowEmoji: Bool?
    /// 正则表达式
    public var predicateString: String?
    
### 9.IDSelectView  
 
 > IDSelectView目前提供3种类型的视图,详细参数较多，请参考demo事例。该视图对JXSegmentedView的再次封装，提取了常用的功能点。
 
 ```
public enum IDSelectViewType {
    case normal  // 标题
    case number  // 含有数字显示
    case dots    // 含有原点显示
}
 ```
 
 ![](https://github.com/Darren-chenchen/IDealist/blob/master/screenShot/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-02-25%20%E4%B8%8B%E5%8D%884.44.26.png?raw=true)
 

![](https://github.com/Darren-chenchen/IDealist/blob/master/screenShot/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-02-25%20%E4%B8%8B%E5%8D%884.44.39.png?raw=true)
  

![](https://github.com/Darren-chenchen/IDealist/blob/master/screenShot/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-02-25%20%E4%B8%8B%E5%8D%884.44.50.png?raw=true)

# IDUtils (扩展方法和工具类)

### String的扩展方法

```
/// 字符串截取函数,截取到指定的位置
public func id_subString(to index: Int) -> String {
   ...
}
/// 字符串截取函数，从指定位置开始截取
public func id_subString(from index: Int) -> String {
   ...
}
/// 从指定位置开始截取, 截取到指定的位置
public func id_subString(from index: Int, offSet: Int) -> String {
   ...        
}
```

### UIView的扩展方法

```
public var id_x: CGFloat
public var id_y: CGFloat
public var id_height: CGFloat
public var id_width: CGFloat
public var id_size: CGSize
public var id_centerX: CGFloat
public var id_centerY: CGFloat

/// 设置渐变色
public func id_addGradientLayer(gradientColors: [UIColor],gradientDirection direction: UIViewGradientDirection, gradientFrame: CGRect? = nil) {
...
}

/// 设置圆角
public func id_border(borderWidth: CGFloat?, borderColor:UIColor?,cornerRadius:CGFloat?) -> UIView{
...
}

/// 设置指定部位的圆角
public func id_borderSpecified(_ specified: UIRectCorner,cornerRadius:CGFloat) -> UIView {
...       
}
```

### URL的扩展

```
// 过滤字符串中的特殊字符
public static func id_init(string:String) -> URL? {
...
}
```

### Array的扩展

```
// 去重
public func id_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
...
}
```

### UIColor的扩展

```
// 通过字符串设置color
public convenience init(hexString: String) {
...
}
// 通过rgb值设置颜色
convenience init(redValue: Int, green: Int, blue: Int, alpha: CGFloat) {
..
}
```

### UIDevice的扩展

```
// 是否是iphonex 系列
public static func id_isX() -> Bool {
...
}
// 是否是ios11以上的系统
public static func id_isIOS11() -> Bool {
..
}
```

### UIViewController的扩展

```
// 获取当前控制器
public func id_getCurrentViewcontroller() -> UIViewController?{
...
}
```