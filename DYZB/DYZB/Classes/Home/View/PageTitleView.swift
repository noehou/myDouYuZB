//
//  PageTitleView.swift
//  DYZB
//
//  Created by Tommaso on 2016/12/8.
//  Copyright © 2016年 Tommaso. All rights reserved.
//

import UIKit
//MARK：-定义协议
protocol PageTitleViewDelegate:class{
    func pageTitleView(titleView:PageTitleView,selectedIndex:Int)
}

//MARK:-定义常量
private let kScrollLineH:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    //MARK：-定义属性
    public var currentIndex:Int = 0
    public var titles:[String]
    weak var delegate:PageTitleViewDelegate?
    //MARK：-懒加载属性
    public lazy var scrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    public lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    public lazy var titleLabels:[UILabel] = [UILabel]()
    //MARK：-自定义构造函数
    init(frame:CGRect,titles:[String]){
        self.titles = titles
        super.init(frame:frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:-设置UI界面
extension PageTitleView{
    public func setupUI(){
        //1、添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2、设置title对应的label
        setupTitleLabels()
        //3、设置底线和滚动的滑块
        setupButtonMenuAndScrollLine()
    }
    
    private func setupTitleLabels(){
        //0、确定label的一些frame的值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated(){
            //1、创建UILable
            let label = UILabel()
            //2、设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3、设置label的frame
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4、将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5、给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    
    private func setupButtonMenuAndScrollLine(){
        //1、添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        //2、添加scrollLine
        //2.1获取第一个Label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK：-监听Label的点击
extension PageTitleView{
    @objc public func titleLabelClick(tapGes:UITapGestureRecognizer){
       //1、获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        //2、获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        //3、切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //4、保存最新的Label 的下标值
        currentIndex = currentLabel.tag
        //5、滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag)*scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations:{self.scrollLine.frame.origin.x = scrollLineX})
        //6、通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK：-对外暴漏的方法
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        //1、取出sourceLabel／targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2、处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3、颜色的渐变（复杂）
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r:kSelectColor.0-colorDelta.0*progress,g:kSelectColor.1-colorDelta.1*progress,b:kSelectColor.2-colorDelta.2*progress)
        //3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g:  kNormalColor.1 + colorDelta.1 * progress, b:  kNormalColor.2 + colorDelta.2 * progress)
        //4.记录最新的index
        currentIndex = targetIndex
    
    }
}
