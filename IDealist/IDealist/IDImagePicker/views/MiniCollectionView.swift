//
//  MiniCollectionView.swift
//  IDImagePicker-IOS
//
//  Created by darren on 2018/12/6.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

typealias MiniCollectionViewCurrentIndexClouse = (Int) -> ()

class MiniCollectionView: UIView {
    
    var currentIndexClouse: MiniCollectionViewCurrentIndexClouse?
    
    var ID = "ID_MINI"
    var VideoID = "VideoID_MINI"
    var layout = UICollectionViewFlowLayout()
    var picArray: Array<PreviewModel>! {
        didSet {
            self.collectionView.reloadData()
        }
    }

    fileprivate lazy var collectionView: UICollectionView = {
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 60, height: 60)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CLPreviewCell.classForCoder(), forCellWithReuseIdentifier: self.ID)
        collectionView.register(CLPreviewVideoCell.classForCoder(), forCellWithReuseIdentifier: self.VideoID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        self.addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: self.collectionView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            ])
    }
    
    var currentIndex: Int = 0 {
        didSet {
            if currentIndex >= self.picArray.count {
                return
            }
            if self.lastIndex == self.currentIndex {
                return
            }
            let indexp1 = IndexPath.init(row: self.lastIndex, section: 0)
            let indexp2 = IndexPath.init(row: self.currentIndex, section: 0)
            self.collectionView.reloadItems(at: [indexp1, indexp2])
            
            self.lastIndex = self.currentIndex
            
            let w: CGFloat = CGFloat((self.currentIndex + 1) * (60 + 5))
            if w > UIScreen.main.bounds.width {
                let offx = w - UIScreen.main.bounds.width
                self.collectionView.setContentOffset(CGPoint.init(x: offx, y: 0), animated: true)
            } else {
                self.collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
        }
    }
    
    var lastIndex = 0
}
extension MiniCollectionView: UICollectionViewDelegate,UICollectionViewDataSource {
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
            cell.currentIndex = self.currentIndex
            cell.clipsToBounds = true
            cell.previewClouse = { [weak self] () in
                if self?.currentIndexClouse != nil {
                    self?.currentIndexClouse!(indexPath.row)
                }
                self?.currentIndex = indexPath.row
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
