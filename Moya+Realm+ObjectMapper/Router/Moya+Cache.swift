//
//  Moya+Cache.swift
//  Assistant
//
//  Created by ucredit-XiaoYang on 2017/11/1.
//  Copyright © 2017年 qiji. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import Moya



public extension Reactive where Base: MoyaProviderType {
    
    
    /*
     * 带缓存的请求
     * 会先返回缓存数据，然后请求成功后再返回最新数据，同时同步数据库
     * 注意：这里缓存请求使用的Observable，默认的请求使用的Single
     * 这里为什么不使用Single，因为Single不会共享状态变化，它要么只能发出一个元素，要么产生一个 error 事件
     *
    **/
    public func cacheRequest(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        return base.cacheReuqest(token, callbackQueue: callbackQueue)
    }
    
}


internal extension MoyaProviderType {
    
    
    internal func cacheReuqest(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        
        return Observable.create { [weak self] observer -> Disposable in
            
            /// 获取缓存数据
            var key = token.baseURL.absoluteString + token.path
            switch token.task {
            case .requestParameters(let parameters, _):
                if let json = parameters.json, !json.isEmpty {
                    key += json
                }
                break
            default:
                break
            }
            
            let realm = try! Realm()
            
            let pre = NSPredicate(format: "key = %@", key)
            let results = realm.objects(ResultModel.self).filter(pre)
            
            if results.count != 0, let filterResult = results.first {
                let creatResponse = Response.init(statusCode: filterResult.statuCode, data: filterResult.data!)
                observer.onNext(creatResponse)
            }
            
            /// 进行正常的网络请求
            let cancellableToken = self?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                    
                    /// 缓存数据
                    let model = ResultModel()
                    model.data = response.data
                    model.statuCode = response.statusCode
                    model.key = key
                    
                    try! realm.write {
                        realm.add(model, update: true)
                    }
                    
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
            
        }
    }
    
}

/// 缓存数据结构
class ResultModel: Object {
    @objc dynamic var data: Data? = nil
    @objc dynamic var statuCode: Int = 0
    @objc dynamic var key: String = ""
    
    //设置数据库主键
    override static func primaryKey() -> String? {
        return "key"
    }
}


public extension Dictionary {
    
    var json: String? {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
        
    }
    
}

