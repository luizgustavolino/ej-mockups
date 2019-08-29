//
//  Store.swift
//  App
//
//  Created by luiz gustavo lino on 14/08/19.
//

import Foundation

struct Store : Codable {
    
    let followable_id:Int
    let owner:Owner
    let seller:Seller
    
    struct Owner : Codable {
        let id:Int
        let short_name:String
        let nickname:String
    }
    
    struct Seller : Codable {
        let id:Int
        let title:String
        let location:String
        let last_seen_on:String
        
        let header_image_public_id:String
        let avatar_image_public_id:String
        
        let stats:Stats
        let counters:Counters
        
    }
    
    struct Stats : Codable {
        let rating:Double                   = 2.5
        let last_sales_statuses:[String]    = ["on_time", "on_time", "cancelled", "delayed", "empty"]
        let average_shipping_time:String    = "3 dias"
        let signed_up_on:String             = "Jan/2014"
    }
    
    struct Counters : Codable {
        let available_products:Int
        let sold_products:Int
        let liked_products:Int
        let followers:Int
        let following:Int
    }

}
