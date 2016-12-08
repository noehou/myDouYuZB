//
//  MainViewController.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/7.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Profile")
        addChildVc(storyName: "Follow")
        
        // Do any additional setup after loading the view.
    }
    
    
    private func addChildVc(storyName: String){
        let childVc = UIStoryboard(name:storyName,bundle:nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
