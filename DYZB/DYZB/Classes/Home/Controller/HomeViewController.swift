//
//  HomeViewController.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/8.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI();
   
    }

}
//MARK:-设置UI界面
extension HomeViewController{
    public func setupUI(){
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
//        let btn = UIButton()
//        btn.setImage(UIImage(named:"logo"), for: .normal)
//        btn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn);
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", highImageName: "", size: .zero)
        
        let size = CGSize(width:40,height:40);
//        let historyBtn = UIButton();
//        historyBtn.setImage(UIImage(named:"image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage(named:"Image_my_history_click"), for: .highlighted)
//        historyBtn.frame = CGRect(origin:.zero,size:size)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
    
        
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
    
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
