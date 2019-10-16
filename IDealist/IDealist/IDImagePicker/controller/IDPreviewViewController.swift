//
//  IDPreviewViewController.swift
//  IDImagePicker-IOS
//
//  Created by darren on 2018/12/6.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

typealias IDPreviewViewControllerDoneClouse = () -> ()

class IDPreviewViewController: CLBaseImagePickerViewController {

    var doneClouse: IDPreviewViewControllerDoneClouse?
    @IBOutlet weak var miniCollectionHYS: NSLayoutConstraint!
    @IBOutlet weak var bottomYS: NSLayoutConstraint!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var editorBtn: UIButton!
    
    @IBOutlet weak var miniCollectView: MiniCollectionView!
    @objc let ID = "Previewcell"
    @objc let VideoID = "VideoPreviewcell"
    
    @objc var picArray: Array<PreviewModel>!
    
    var bottomH: CGFloat = 120
    
    var layout = UICollectionViewFlowLayout()
    
    fileprivate lazy var collectionView: UICollectionView = {
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-bottomH), collectionViewLayout: layout)
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-bottomH-KNavgationBarHeight)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CLPreviewCell.classForCoder(), forCellWithReuseIdentifier: self.ID)
        collectionView.register(CLPreviewVideoCell.classForCoder(), forCellWithReuseIdentifier: self.VideoID)
        
        return collectionView
    }()
    
    lazy var chooseView: ChooseView = {
        let choose = ChooseView.show()
        choose.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)
        choose.common()
        choose.chooseClouse = {[weak self] () in
            self?.clickBtn()
            self?.setSureBtn()
        }
        return choose
    }()
    
    @objc var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.miniCollectionHYS.constant = 120 + SaveAreaHeight
        self.bottomH = self.self.miniCollectionHYS.constant

        initView()
        CLNotificationCenter.addObserver(self, selector: #selector(receiverNotification(notic:)), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        self.miniCollectView.currentIndexClouse = {[weak self] (index) in
            self?.collectionView.setContentOffset(CGPoint.init(x: CGFloat(index) * UIScreen.main.bounds.width, y: 0), animated: false)
        }
        self.setSureBtn()
    }
    func initConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.chooseView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints([
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: KNavgationBarHeight),
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -bottomH)
            ])
        
        let y: CGFloat = UIDevice.id_isX() == true ? 48:28
        self.chooseView.addConstraint(NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 25))
        self.chooseView.addConstraint(NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 25))
        self.customNavBar.addConstraints([
            NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: y),
            NSLayoutConstraint.init(item: self.chooseView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
            ])
        
    }
    func initView() {
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(collectionView)
        
        self.sureBtn.backgroundColor = CLPickersTools.instence.tineColor
        CLViewsBorder(self.sureBtn, borderWidth: 0, cornerRadius: 4)
        self.sureBtn.setTitle(sureStr, for: UIControl.State.normal)
        self.editorBtn.setTitle(editorStr, for: UIControl.State.normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toobar.alpha = 0
        self.customNavBar.navLine.isHidden = true
        self.backBtn.isHidden = false
        self.customNavBar.backgroundColor = UIColor(white: 0, alpha: 0.67)
        self.backBtn.setImage(UIImage(named: "icn_icn_back_white", in: BundleUtil.getCurrentBundle(), compatibleWith: nil), for:UIControl.State())
        self.view.bringSubviewToFront(self.customNavBar)
        self.setselectimg()
        self.customNavBar.addSubview(self.chooseView)
        self.customNavBar.bringSubviewToFront(self.rightBtn)
        self.rightBtn.isUserInteractionEnabled = false
        
        initConstraints()
        
        self.updateCell()
        
        self.miniCollectView.picArray = self.picArray
    }
    
    func clickBtn() {
        
        let model = self.picArray[self.currentPage-1]
        
        self.chooseView.isSelect = !self.chooseView.isSelect
        if self.chooseView.isSelect {
            
            self.setselectimg()
            model.isCheck = true
            CLPickersTools.instence.savePicture(asset: (model.phAsset)!, isAdd: true)
        } else {
            self.chooseView.isSelect = false
            model.isCheck = false
            CLPickersTools.instence.savePicture(asset: (model.phAsset)!, isAdd: false)
        }
        
        // 通知列表刷新状态
        CLNotificationCenter.post(name: NSNotification.Name(rawValue:PreviewForSelectOrNotSelectedNotic), object: model)
    }
    override func backBtnclick() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func receiverNotification(notic: Notification){
        
        let orient = UIDevice.current.orientation
        switch orient {
        case .portrait :
            self.updateCell()
            //print("屏幕正常竖向")
            break
        case .portraitUpsideDown:
            //print("屏幕倒立")
            self.updateCell()
            break
        case .landscapeLeft:
            //print("屏幕左旋转")
            self.updateCell()
            break
        case .landscapeRight:
            //print("屏幕右旋转")
            self.updateCell()
            break
        default:
            break
        }
    }
    func updateCell() {
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-bottomH-KNavgationBarHeight)
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
        self.collectionView.setContentOffset(CGPoint(x: self.view.frame.size.width * CGFloat(self.currentPage-1), y: 0), animated: true)
    }
    deinit {
        CLNotificationCenter.removeObserver(self)
        print("CLPreviewViewController销毁")
    }
    @IBAction func clickEditorBtn(_ sender: Any) {
        let vc = IDEditorViewController.init(nibName: "IDEditorViewController", bundle: BundleUtil.getCurrentBundle())
        vc.model = self.picArray[self.currentPage-1]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func clickSureBtn(_ sender: Any) {
        if self.doneClouse != nil {
            self.doneClouse!()
        }
    }
}

extension IDPreviewViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.picArray[indexPath.row]
        if model.phAsset?.mediaType == .image {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.ID, for: indexPath) as! CLPreviewCell
            model.index = indexPath.row
            cell.identifyIndex = indexPath.row
            cell.modelArr = self.picArray
            cell.model = model
            cell.previewClouse = {() in
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.VideoID, for: indexPath) as! CLPreviewVideoCell
            cell.model = model
            cell.previewClouse = {() in
            }
            return cell
            
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let dragstop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
        if dragstop {
            self.miniCollectView.currentIndex = self.currentPage-1
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = (Int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.picArray.count
        
        let cellArr = self.collectionView.visibleCells
        for cell in cellArr {
            if cell.classForCoder == CLPreviewVideoCell.classForKeyedArchiver() {
                let cellVedio = cell as! CLPreviewVideoCell
                if cellVedio.player != nil {
                    cellVedio.player?.pause()
                    cellVedio.playBtn.isHidden = false
                    cellVedio.removeObserver()
                }
            }
        }
        
        
        self.currentPage = page+1
        
        let model = self.picArray[page]
        if model.isCheck {
            self.setselectimg()
        } else {
            self.chooseView.isSelect = false
        }
    }
    
    func setselectimg() {
        self.chooseView.isSelect = true
    }
    
    func setSureBtn() {
        if CLPickersTools.instence.getSavePictureCount() > 0 {
            let title = "\(sureStr)(\(CLPickersTools.instence.getSavePictureCount()))"
            self.sureBtn.setTitle(title, for: .normal)
            self.sureBtn.isEnabled = true
        } else {
            self.sureBtn.setTitle(sureStr, for: .normal)
            self.sureBtn.isEnabled = false
        }
    }
}

