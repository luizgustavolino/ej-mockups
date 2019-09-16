//
//  Product.swift
//  App
//
//  Created by Luiz Gustavo Lino on 6/Sep/19.
//

import Foundation

struct Product : Codable {

    let id:Int
    let title:String
    let description:String
    let canonical_url:URL
    let sub_category_slug:String
    let bundle_allowed:Bool
    let hand_delivery:Bool

    let kilograms:Double
    let used:Bool
    let size:String

    struct Brand : Codable {
        let name:String
        let slug:String
    }

    let brand:Brand

    struct FallbackPrice : Codable {
        let discount:Int
        let price:Int
    }

    let fallback_pricing:FallbackPrice
    let original_price:Int

    let photos:[String]
    
    struct Comments : Codable {
        let submit_allowed:Bool
        let replace_with_faq:Bool
    }
    
    let comments: Comments

    let owner_id:Int?
    let seller_id:Int
}
