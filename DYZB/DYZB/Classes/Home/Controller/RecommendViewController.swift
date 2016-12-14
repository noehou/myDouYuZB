//
//  RecommendViewController.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/9.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90



class RecommendViewController: BaseAnchorViewController {
    //MARK：-懒加载属性
    public lazy var recommendVM : RecommendViewModel = RecommendViewModel()
//    public lazy var collectionView:UICollectionView = {
//        //1、创建布局
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = kItemMargin
//        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
//        
//        //2、创建UICollectionView
//       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.white
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        
//        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
//        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
//        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil),forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,withReuseIdentifier: kHeaderViewID)
//        return collectionView
//    }()
    
    public lazy var cycleView : RecommendCycleView = {
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x:0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        cycleView.backgroundColor = UIColor.purple
        return cycleView
    }()
    
    public lazy var gameView : RecommendGameView = {
       let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    

}

//MARK:-设置UI界面内容
extension RecommendViewController{
    override func setupUI(){
        //1、先调用super.setupUI()
        super.setupUI()
        //2、将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        //3、将gameView添加collectionView中
        collectionView.addSubview(gameView)
        //4、设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK：-请求数据
extension RecommendViewController {
     override func loadData(){
       // NetworkTools.requestData(type: .GET, URLString: "http://httpbin.org/get", parameters: ["name":"noe"], finishedCallback: {(result) in
          //  print(result)
       // })
        
        //0、给父类中的viewModel进行赋值
        baseVM = recommendVM
        //1、请求推荐数据
        recommendVM.requestData {
            //1、展示推荐数据
            self.collectionView.reloadData()
            
            //2、将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            
            //2.1、移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            //2.2、添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        
        //2、请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1、取出prettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            //1、设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}


