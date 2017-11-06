//
//  HomePageModel.swift
//  Assistant
//
//  Created by ucredit-XiaoYang on 2017/11/1.
//  Copyright © 2017年 qiji. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

/// 首页班级列表
final class HomePageModel: Cacheable, Jsonable {
    
    @objc dynamic var currentPage: Int = 0
    @objc dynamic var firstPageUrl: String?
    @objc dynamic var lastPage: Int = 0
    @objc dynamic var lastPageUrl: String?
    @objc dynamic var path: String?
    @objc dynamic var perPage: Int = 0
    @objc dynamic var total: Int = 0
    var data: List<Book>?

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        currentPage     <- map["current_page"]
        firstPageUrl    <- map["first_page_url"]
        lastPage        <- map["last_page"]
        lastPageUrl     <- map["last_page_url"]
        path            <- map["path"]
        perPage         <- map["per_page"]
        total           <- map["total"]
        data            <- (map["data"], ListTransform<Book>())
    }
    
}

/// 书籍
final class Book: Cacheable, Jsonable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var countRememberedCards: Int = 0
    @objc dynamic var countCards: Int = 0
    var userCards: List<Course>?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                      <- map["id"]
        name                    <- map["name"]
        countRememberedCards    <- map["count_remembered_cards"]
        countCards              <- map["count_cards"]
        userCards               <- (map["user_cards"], ListTransform<Course>())
    }
    
}

/// 课程
final class Course: Cacheable, Jsonable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var lastReadAt: Date?
    @objc dynamic var countRead: Int = 0
    @objc dynamic var lastRememberedAt: Int = 0
    @objc dynamic var countRemembered: Int = 0
    @objc dynamic var card: Card?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        countRead           <- map["count_read"]
        lastRememberedAt    <- map["last_remembered_at"]
        countRemembered     <- map["count_remembered"]
        card                <- map["card"]
        lastReadAt          <- (map["last_read_at"], DateTransform())
    }
    
}


final class Card: Cacheable, Jsonable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
       
    }
}
