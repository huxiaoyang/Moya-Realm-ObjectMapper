//
//  MoyaPlugin.swift
//  Assistant
//
//  Created by ucredit-XiaoYang on 2017/10/16.
//  Copyright © 2017年 qiji. All rights reserved.
//

import Foundation
import Moya
import Result


final class MoyaPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        // 获取请求的URL
        //        guard let requestURLString = request.request?.url?.absoluteString else { return }
        
        // 这里可做一些基本操作，例如HUD.show()
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // 只监听失败
        //        guard case Result.failure(_) = result else { return }
        
        // 这里可做一些基本操作，例如HUD.hide()
    }
    
}
