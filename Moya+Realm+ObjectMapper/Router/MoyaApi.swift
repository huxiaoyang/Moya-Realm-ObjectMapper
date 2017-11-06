//
//  MoyaApi.swift
//  Assistant
//
//  Created by ucredit-XiaoYang on 2017/10/16.
//  Copyright © 2017年 qiji. All rights reserved.
//

import Foundation
import Moya

// API
enum MoyaApi {
    /// 首页列表数据
    case homePage(page: Int)
}



extension MoyaApi: TargetType {
    
    var baseURL: URL {
        return URL(string: Moya_baseURL)!
    }
    
    /// 要附加到`baseURL'后以形成完整的URL的路径
    var path: String {
        
        switch self {
        
        case .homePage:
            return "/users/packages"
            
        }
        
    }
    
    /// 请求中使用的HTTP方法
    var method: Moya.Method {
        return .get
    }
    
    /// 请求头
    var headers: [String : String]? {
        return ["Accept" : "application/vnd.xiaoxiaozhujiao.v20171016+json"]
    }
    
    /// 要执行的HTTP任务的类型
    /// 请求中要编码的参数
    var task: Task {
        
        switch self {
        case .homePage(let page):
            let param: [String : Any] = ["page_size" : 10,
                                         "page" : page]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
        
    }
    
    
    /// 提供存根数据用于测试
    /// 只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
}
