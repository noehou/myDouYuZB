//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/10.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    public lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    public lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//MARK：-发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback : @escaping () -> ()){
        //0、定义参数
        let parameters = ["limit" : "4","offset" : "0","time" : Date.getCurrentTime()]
        let dGroup = DispatchGroup()
        //1、请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime() as NSString], finishedCallback:{(result) in
            //1、将result转为字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2、根据data的key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3、遍历数组，获取字典，并且字典转成模型对象
            
            
            //3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.3获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
                
            }
            //3.4离开组
            dGroup.leave()
        })
        
        //2、请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters as [String : NSString]?, finishedCallback:{(result) in
            //1、将result转为字典类型
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2、根据data的key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3、遍历数组，获取字典，并且字典转成模型对象
           
            
            //3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.3获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
                
            }
            dGroup.leave()
        })
        //3、请求后面部分游戏数据
        dGroup.enter()
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters, finishedCallback:{(result) in
            dGroup.leave()
        })
//        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters as [String : NSString]?, finishedCallback:{(result) in
//            //1、将result转为字典类型
//            guard let resultDict = result as? [String : NSObject] else {return}
//            
//            //2、根据data的key，获取数组
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
//            
//            //3、遍历数组，获取字典，并且字典转成模型对象
//            for dict in dataArray {
//                let group = AnchorGroup(dict: dict)
//                self.anchorGroups.append(group)
//            }
//            //3.2离开组
//              dGroup.leave()
//            })
           //6、所有的数据都请求到，之后进行排序
            dGroup.notify(queue: DispatchQueue.main){
                self.anchorGroups.insert(self.prettyGroup, at: 0)
                self.anchorGroups.insert(self.bigDataGroup, at: 0)
                 finishCallback()
                
        }
        
        }
    
    //请求无限轮播的数据
    func requestCycleData(finishCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6",
        parameters: ["version" : "2.300"], finishedCallback: { (result) in
            //1、获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            //2、根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3、字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict : dict))
            }
            finishCallback()
        })
    }

}



