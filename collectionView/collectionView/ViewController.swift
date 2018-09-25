//
//  ViewController.swift
//  collectionView
//
//  Created by lapse 涛 on 2017/11/20.
//  Copyright © 2017年 lapse 涛. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView : UICollectionView!
    
    //定义重用标识
    let itemIdentifier = "item"
    //区头 区尾
    let headerIdentifier = "header"
    //注册重用标识
    let footerIdentifier = "footer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.createUI()
    }

}

extension ViewController{
    
    func createUI(){
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        //创建布局对象
        let flowLayout = UICollectionViewFlowLayout()
        
        //设置item的大小
        flowLayout.itemSize = CGSize(width: (w-20*4)/3, height: 80)
        
        //设置滚动的方向  horizontal水平混动
        flowLayout.scrollDirection = .vertical
        
        //设置最小行间距
        flowLayout.minimumLineSpacing = 10
        
        //设置最小列间距
        flowLayout.minimumInteritemSpacing = 10
        
        //设置分区缩进量
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        //设置区头的大小
        flowLayout.headerReferenceSize = CGSize(width: 0, height: self.view.frame.width*0.55)
        flowLayout.footerReferenceSize = CGSize(width: 0, height: h - 80 - w * 0.55 - 80 * 2 - 40)
        
        //创建一个UICollectionView对象
        //UICollectionView布局比较复杂，所以专门为他设计了一个布局类UICollectionView，但是很少直接使用他的基类，都是实用他的子类UICollectionViewFlowLayout

        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: w, height: h-80), collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = UIColor.white
        
        //注册item
        
        //UICollectionViewCell就是一个视图上面什么控件都没有，当我们要展示文字或图片，就需要自定义cell
        collectionView.register(UINib.init(nibName: "itemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "celll")
        
        //注册区头
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        collectionView.register(UINib.init(nibName: "headerCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCollectionReusableView")
        
        //注册区尾
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier)
        
        //指定数据源代理
        collectionView.dataSource = self
        
        //指定业务代理
        collectionView.delegate = self
        
        //添加到父类视图
        self.view.addSubview(collectionView)
    
        
        let gobuyBtn = UIButton.init(frame: CGRect.init(x: 0, y: h - 80, width: w, height: 80))
        gobuyBtn.setTitle("立即购买", for: .normal)
        gobuyBtn.backgroundColor = UIColor.red
        self.view.addSubview(gobuyBtn)
        
    }
    
}

extension ViewController{
    
    
    func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : font], context: nil).size
    }
    
    func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize.init(width: 900, height: height)
        
        let dic = NSDictionary.init(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context: nil).size
        return strSize.width
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //返回区头视图
        if kind == UICollectionElementKindSectionHeader{
//            let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath)
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCollectionReusableView", for: indexPath)
            
            
            return headerView
//            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width*0.4))
//            imageView.backgroundColor = UIColor.red
//            headerview.addSubview(imageView)
//
//            let coinLab = UILabel.init(frame: CGRect.init(x: 20, y: 45, width: 150, height: 25))
//            coinLab.text = "金币数"
//            coinLab.textColor = UIColor.white
//            coinLab.font = UIFont.systemFont(ofSize: 22)
//            headerview.addSubview(coinLab)
//
//            let coinNum = UILabel.init(frame: CGRect.init(x: 20, y: coinLab.frame.maxY+10, width: 100, height: 30))
//            coinNum.text = "10000"
//            coinNum.textColor = UIColor.white
//            coinNum.font = UIFont.systemFont(ofSize: 27)
//            headerview.addSubview(coinNum)
//
//            let iconImg = UIImageView.init(frame: CGRect.init(x: 125, y: coinLab.frame.maxY+10, width: 40, height: 40))
//            iconImg.backgroundColor = UIColor.cyan
//            headerview.addSubview(iconImg)
//
//            let nilView = UIView.init(frame: CGRect.init(x: 0, y: imageView.frame.maxY, width: self.view.frame.width, height: 6))
//            nilView.backgroundColor = UIColor.lightGray
//            headerview.addSubview(nilView)
//
//            let hy = self.view.frame.width*0.4 + 6
//            let hy1 = (self.view.frame.width*0.55 - hy - 10)/2
//
//            let tipLab = UILabel.init(frame: CGRect.init(x: 20, y: hy+hy1, width: 200, height: 20))
//            tipLab.text = "请选择充值金额"
//            tipLab.textAlignment = .left
//            tipLab.textColor = UIColor.black
//            tipLab.font = UIFont.systemFont(ofSize: 20)
//            headerview.addSubview(tipLab)
//
//            headerview.backgroundColor = UIColor.white
            
//            return headerview
        }
        else{
            //返回区尾视图
            let footerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier, for: indexPath)
            footerview.backgroundColor = UIColor.gray
            return footerview
        }
   
    }
    
    
    
    //返回CollectionView有多少分区
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //返回一个分区有多少个Item的方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    //返回UICollectionViewCell视图
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celll", for: indexPath) as! itemCollectionViewCell
        
//        cell.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        cell.backgroundColor = UIColor.gray
        
        return cell
    }
    
    //MARK:- UICollectionDelegateFlowLayout协议方法
    //选中item会触发的方法//加导航栏
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print("item所在分区的下标\(indexPath.section)")
        //        print("item所在分区中的下标\(indexPath.item)")
    }
    
    //返回item高度的方法
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return indexPath.section % 2 == 0 ? CGSize(width: (self.view.frame.width - 4*20)/4, height: 80) : CGSize(width: 200, height: 120)
//
//    }
    
//    返回分区缩进量的方法
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if section == 0 {
//            return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
//        }
//        else{
//            return UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
//
//        }
//    }
    
    //返回区头大小的方法
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize(width: 0, height: 150)
//        }else{
//            return CGSize(width: 0, height: 50)
//        }
//    }
    
    
    //返回区尾视图的方法
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if section != 0 {
//            return CGSize(width: 0, height: 20)
//        }
//        else{
//            return CGSize(width: 0, height: 100)
//        }
//    }
    
    // 最小行间距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 20
//
//    }
//
    // 最小item间距
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//        return 20
//
//    }

}























