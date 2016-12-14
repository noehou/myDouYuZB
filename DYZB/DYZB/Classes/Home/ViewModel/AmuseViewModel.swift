//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/14.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
