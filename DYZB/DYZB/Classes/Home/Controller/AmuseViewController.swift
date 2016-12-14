//
//  AmuseViewController.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/14.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit


class AmuseViewController: BaseAnchorViewController {
    //MARK：懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}


//MARK:-请求数据
extension AmuseViewController {
     override func loadData() {
        //1、给父类中的viewModel进行赋值
        baseVM = amuseVM
        //2、请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

