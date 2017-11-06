//
//  MoyaConfig.swift
//  Moya+Realm+ObjectMapper
//
//  Created by ucredit-XiaoYang on 2017/11/6.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


/// 定义基础域名
let Moya_baseURL = "http://zhujiaoapi.lawyer5.cn"


/// 定义返回的JSON数据字段
let RESULT_CODE = "status_code"      //状态码

let RESULT_MESSAGE = "message"  //错误消息提示


/// model配置
protocol Jsonable: Mappable {}
class Cacheable: Object {}
