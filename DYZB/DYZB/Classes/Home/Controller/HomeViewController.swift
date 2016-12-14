//
//  HomeViewController.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/8.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit
private let kTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {

    //MARK：- 懒加载属性
    public lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
       titleView.delegate = self as PageTitleViewDelegate?
        return titleView
    }()
    
    public lazy var pageContentView:PageContentView = {[weak self] in
        //1、确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //2、确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        for _ in 0..<1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self as PageContentViewDelegate?
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI();
   
    }

}
//MARK:-设置UI界面
extension HomeViewController{
    public func setupUI(){
        //0、不需要调整UISCcrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1、设置导航栏
        setupNavigationBar()
        //2、添加TitleView
        view.addSubview(pageTitleView)
        //3、添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
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

//MARK:-遵守PageTitleViewDelegate协议
extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        pageContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
}

extension HomeViewController:PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progess: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progess, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
