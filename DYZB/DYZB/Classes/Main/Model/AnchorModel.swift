
//
//  AnchorModel.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/10.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id : Int = 0
    //房间图片对应的URLString
    var vertical_src : String = ""
    //判断是手机直播还是电脑直播
    //0：电脑直播 1:手机直播
    var isVertical :Int = 0
    //房间名称
    var roomName : String = ""
    //主播昵称
    var nickName : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}