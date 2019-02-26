

import UIKit

public typealias clickCancelButtonClouse = () -> ()
public typealias clickSearchButtonClouse = (String) -> ()

public class IDSearchBar: UIView, UISearchBarDelegate {
    
    public var clickCancelButton: clickCancelButtonClouse?
    public var clickSearchButton: clickSearchButtonClouse?

    lazy var search: UISearchBar = {
        let searchBar = UISearchBar.init(frame: self.bounds)
        return searchBar
    }()

    /// 占位文字
    public var id_placeHolder: String = "请输入搜索关键字" {
        didSet {
            self.search.placeholder = id_placeHolder
        }
    }
    /// 搜索图片
    public var id_searchImage: UIImage? = UIImage(named: "ic_ssearch", in: BundleUtil.getCurrentBundle(), compatibleWith: nil) {
        didSet {
            self.search.setImage(id_searchImage, for: .search, state: .normal)
        }
    }
    /// 搜索框背景颜色
    public var id_textFieldBgColor = UIColor.white {
        didSet {
            let textF = self.search.value(forKeyPath: "searchField") as! UITextField
            textF.backgroundColor = id_textFieldBgColor
        }
    }
    /// 搜索框字体大小
    public var id_textFieldFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            let textF = self.search.value(forKeyPath: "searchField") as! UITextField
            textF.font = id_textFieldFont
        }
    }
    /// 右边按钮的文字
    public var id_cancelButtonTitle = "取消" {
        didSet {
            let btn = self.search.value(forKey: "cancelButton") as! UIButton
            btn.setTitle(id_cancelButtonTitle, for: .normal)
        }
    }
    /// 右边按钮的文字颜色
    public var id_cancelButtonTitleColor = RGBAColor(95,95,95,1) {
        didSet {
            let btn = self.search.value(forKey: "cancelButton") as! UIButton
            btn.setTitleColor(id_cancelButtonTitleColor, for: .normal)
        }
    }
    /// 右边按钮的文字字体
    public var id_cancelButtonTitleFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            let btn = self.search.value(forKey: "cancelButton") as! UIButton
            btn.titleLabel?.font = id_cancelButtonTitleFont
        }
    }
    
    /// 是否显示右边的按钮
    public var id_showRightBtn = false {
        didSet {
            self.search.showsCancelButton = id_showRightBtn
        }
    }
    /// 搜索容器的背景色
    public var id_containerBgColor = RGBAColor(239, 239, 244, 1) {
        didSet {
            self.search.backgroundImage = self.imageWithColor(color: id_containerBgColor, size: search.frame.size)
        }
    }
    /// 搜索框的圆角大小
    public var id_cornerRadius: CGFloat = 2 {
        didSet {
            let textF = self.search.value(forKeyPath: "searchField") as! UITextField
            textF.layer.cornerRadius = id_cornerRadius
            textF.layer.masksToBounds = true
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commom()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commom()
    }
    
    func commom() {
        self.search.placeholder = self.id_placeHolder
        self.search.delegate = self
        self.search.setImage(UIImage(named:"ic_ssearch"), for: .search, state: .normal)
        self.search.showsCancelButton = self.id_showRightBtn
        self.search.frame = self.bounds
        
        // 去掉背景的灰色
        self.search.backgroundImage = self.imageWithColor(color: UIColor.groupTableViewBackground, size: search.frame.size)
        
        // 修改搜索框的样式
        let textF = self.search.value(forKeyPath: "searchField") as! UITextField
        textF.backgroundColor = self.id_textFieldBgColor
        textF.layer.cornerRadius = id_cornerRadius
        textF.layer.masksToBounds = true
        textF.font = UIFont.systemFont(ofSize: 12)
        
        // 防止xib创建的尺寸错误
        self.search.autoresizingMask = .flexibleWidth
        textF.autoresizingMask = .flexibleWidth
        
        self.addSubview(self.search)
    }
    
    //取消searchBar背景色
    func imageWithColor(color:UIColor,size:CGSize) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    func isIOS11() -> Bool{
        if #available(iOS 11.0, *) {
            return true
        } else {
            return false
        }
    }
    private func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    private func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.count == 0 {
            return
        }
        
        if self.clickSearchButton != nil {
            self.clickSearchButton!(searchBar.text!)
        }
    }
    private func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if self.clickCancelButton != nil {
            self.clickCancelButton!()
        }
    }
    private func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("===========\(searchText)")
    }
}
