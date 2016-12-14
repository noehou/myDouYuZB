//
//  BaseViewModel.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/14.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
 }

extension BaseViewModel {
    func loadAnchorData(URLString : String,parameters : [String : Any]? = nil,
                        finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: URLString,parameters: parameters as! [String : NSString]?, finishedCallback:{(result) in
            //1、对界面进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            //2、遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict : dict))
            }
            
            //3、完成回调
            finishedCallback()
        })
    }
}
