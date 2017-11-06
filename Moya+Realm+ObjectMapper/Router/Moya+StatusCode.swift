//
//  MoyaExtension.swift
//  Assistant
//
//  Created by ucredit-XiaoYang on 2017/10/16.
//  Copyright © 2017年 qiji. All rights reserved.
//

import Foundation
import RxSwift
import Moya


extension Response {
    
    func throwErrorStatusCode() throws -> Response {
        
        let jsonObject = try mapJSON()
        let json = jsonObject as! [String : Any]
        
        if json[RESULT_CODE] == nil {
            return self
        }
        
        guard let c = json[RESULT_CODE] as? Int, c == 200  else {
            throw MoyaError.requestMapping(json[RESULT_MESSAGE] as! String)
        }
        
        return self
    }
    
}


extension ObservableType where E == Response {
    
    func throwErrorStatusCode() -> Observable<E> {
        return flatMap { response -> Observable<E> in
            return Observable.just(try response.throwErrorStatusCode())
        }
    }
    
    /// 显示错误信息 toast
    /// 建议在 throwErrorStatusCode() 后使用，否则只会
    func showErrorToast() -> Observable<E> {
        return self.do(onError: { error in
            // 此处是一个封装好toast，自己封装，自己调用
            print("toast is showing")
//            UIViewController.showStatus(title: error.localizedDescription)
        })
    }
    
}


public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    func throwErrorStatusCode() -> Single<ElementType> {
        return flatMap { response -> Single<ElementType> in
            return Single.just(try response.throwErrorStatusCode())
        }
    }
    
    /// 显示错误信息 toast
    /// 建议在 throwErrorStatusCode() 后使用，否则只会响应http错误
    func showErrorToast() -> Single<E> {
        return self.do(onError: { error in
            // 此处是一个封装好toast，自己封装，自己调用
            print("toast is showing")
//            UIViewController.showStatus(title: error.localizedDescription)
        })
    }
    
}

