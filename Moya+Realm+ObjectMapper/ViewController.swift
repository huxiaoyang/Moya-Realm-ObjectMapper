//
//  ViewController.swift
//  Moya+Realm+ObjectMapper
//
//  Created by ucredit-XiaoYang on 2017/11/6.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 正常请求
        provider.rx.request(.homePage(page: 1))
        .throwErrorStatusCode()
        .showErrorToast()
        .mapObject(HomePageModel.self)
        .subscribe { event in
            switch event {
            case .success(let model):
                print("response model is \(model)")
            case .error(let error):
                print(error)
            }
        }
        .disposed(by: disposeBag)
        
        
        
        /// 带缓存的请求，可以打开注释，自己试一下效果
        
//        provider.rx.cacheRequest(.homePage(page: 1))
//            .throwErrorStatusCode()
//            .showErrorToast()
//            .mapObject(HomePageModel.self)
//            .subscribe { event in
//                switch event {
//                case .success(let model):
//                    print("response model is \(model)")
//                case .error(let error):
//                    print(error)
//                }
//            }
//            .disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

