//
//  LegacyStore.swift
//  App
//
//  Created by luiz gustavo lino on 14/08/19.
//

import Foundation
import Vapor

struct LegacyStoreIDs : Codable {
    let seller_id:Int?
    let owner_id:Int?
}

struct LegacyStore : Codable {
    let id:Int
    let nickname:String
    let name:String
    let title:String
    let avatar:Photo
    let gender:String
    let city:String
    let follow_user:Bool
    let created_at:String
    let header:Photo
    let description:String?
    let can_sell_with_bundle:Bool
    let boosted_bundle:BoostedBundle?
    let store:LegacyStoreIDs?
    
    var asStore:Store {
        return Store(seller_id: store?.seller_id,
                     owner_id: store?.owner_id,
                     id_to_follow: store?.owner_id ?? store?.seller_id,
                     title: title,
                     nickname: nickname,
                     displayable_name: name,
                     city: city,
                     created_at: created_at,
                     avatar: avatar,header: header)
    }
    
    var counters:Counters
}

