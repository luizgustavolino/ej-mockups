//
//  LegacyStore.swift
//  App
//
//  Created by luiz gustavo lino on 14/08/19.
//

import Foundation
import Vapor

struct Photo : Codable{
    let image_public_id:String
}

struct BoostedBundle : Codable {
    let enabled:Bool
    let current_values:[Int]
}

struct Counters : Codable {
    let available_products_count:Int
    let sold_products_count:Int
    let following_count:Int
    let followers_count:Int
    let likes_count:Int
}

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

        let short_name = String(name.split(separator: " ").first ?? "")

        return Store(followable_id: id,
              owner_id: store?.owner_id,
              seller_id: store?.seller_id,
              short_name: short_name,
              nickname: nickname,
              title: title,
              location: city,
              header: header,
              avatar: avatar)
    }

    var asStats:Stats {

        let statsCounters = Stats.Counters(
            available_products: counters.available_products_count,
            sold_products: counters.sold_products_count,
            liked_products: counters.likes_count,
            followers: counters.followers_count,
            following: counters.following_count)

        return Stats(counters: statsCounters)
        
    }
    
    var counters:Counters
}

