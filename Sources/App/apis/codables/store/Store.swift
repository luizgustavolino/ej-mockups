//
//  Store.swift
//  App
//
//  Created by luiz gustavo lino on 14/08/19.
//

import Foundation

struct Store : Codable {
    
    let followable_id:Int
    let owner_id:Int?
    let seller_id:Int?

    let canonical_url:URL

    let short_name:String
    let nickname:String
    let title:String
    let location:String
    let signed_up_on:String = "Jan/2014"
    let boosted_bundle:Bool

    let header:Photo
    let avatar:Photo
    
}


struct Stats : Codable {

    struct Counters : Codable {
        let available_products:Int
        let sold_products:Int
        let liked_products:Int
        let followers:Int
        let following:Int
    }

    let counters:Counters

    let rating:Double                   = 4.5
    let last_sales_statuses:[String]    = ["on_time", "on_time",
                                           "cancelled", "delayed", "empty"]
    let average_shipping_time:String?   = "3 dias"
    let signed_up_on:String             = "Jan/2014"

}


