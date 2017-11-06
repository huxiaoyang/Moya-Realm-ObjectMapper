//
//  MoyaProvider.swift
//  Assistant
//
//  Created by ucredit-XiaoYang on 2017/10/16.
//  Copyright © 2017年 qiji. All rights reserved.
//

import Foundation
import Moya


/// 定义请求超时时间
let requestClosure = { (endpoint: Endpoint<MoyaApi>, done: @escaping MoyaProvider<MoyaApi>.RequestResultClosure) in

    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 30
        done(.success(request))
    } catch {
        done(.failure(MoyaError.requestMapping("错误的request")))
    }
    
}

let provider = MoyaProvider<MoyaApi>(requestClosure: requestClosure,
                                     plugins: [NetworkLoggerPlugin(verbose: true), MoyaPlugin()])

