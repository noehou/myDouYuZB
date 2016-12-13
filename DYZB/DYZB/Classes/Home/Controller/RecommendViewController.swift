//
//  RecommendViewController.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/9.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit


private let kItemMargin:CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW*3/4
private let kPrettyItemH = kItemW*4/3
private let kHeaderViewH:CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    //MARK：-懒加载属性
    public lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    public lazy var collectionView:UICollectionView = {
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2、创建UICollectionView
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil),forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    public lazy var cycleView : RecommendCycleView = {
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x:0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        cycleView.backgroundColor = UIColor.purple
        return cycleView
    }()
    //MARK:-系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        //设置UI界面
        setupUI()
        //发送网络请求
        loadData()
    }

}

//MARK:-设置UI界面内容
extension RecommendViewController{
    public func setupUI(){
        //2、将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        //1、将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
       
        //3、设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK：-请求数据
extension RecommendViewController {
    public func loadData(){
       // NetworkTools.requestData(type: .GET, URLString: "http://httpbin.org/get", parameters: ["name":"noe"], finishedCallback: {(result) in
          //  print(result)
       // })
        //1、请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        
        //2、请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
//MARK:-遵守UICollectionView的数据协议
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       //0、取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
         //1、定义cell
        var cell : CollectionBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
            as! CollectionPrettyCell
            
           
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
            as! CollectionNormalCell
            
        }
        
        //4、将模型赋值给Cell
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1、获取section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2、取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
         return CGSize(width: kItemW, height: kNormalItemH)
    }
}


