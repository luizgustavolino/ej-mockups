//
//  Store.swift
//  App
//
//  Created by luiz gustavo lino on 14/08/19.
//

import Foundation

struct Photo : Codable{
    let image_public_id:String
}

struct BoostedBundle : Codable {
    let enabled:Bool
    let current_values:[Int]
}

struct Store : Codable {
    let seller_id:Int?
    let owner_id:Int?
    var id_to_follow: Int?
    let nickname:String
    let name:String
    let gender:String
    let city:String
    var created_at:String
    var avatar:Photo?
    let header:Photo?
    let boosted_bundle:BoostedBundle?
}

struct Counters : Codable {
    let available_products_count:Int
    let sold_products_count:Int
    let following_count:Int
    let followers_count:Int
    let likes_count:Int
}
