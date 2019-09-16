//
//  LegacyProduct.swift
//  App
//
//  Created by Luiz Gustavo Lino on 6/Sep/19.
//

import Foundation


extension LegacyProductModel {
    func asProduct() -> Product {
        
        let url = URL(string: "https://enjoei.com.br/p/\(id)")!
        let brandMapping = Product.Brand(name: brand.name ?? "", slug: brand.slug ?? "")
        let pricingMapping = Product.FallbackPrice(discount: prices.discount, price: prices.current)
        let photosMapping = photos.compactMap{ $0.image_public_id }
        let comments = Product.Comments(submit_allowed: true, replace_with_faq: true)
        
        return Product(id: Int(id),
                       title: title,
                       description: description,
                       canonical_url: url,
                       sub_category_slug: category_slug,
                       bundle_allowed: false,
                       hand_delivery: shipping?.style == "hand_deliver",
                       kilograms: 1.2, used: used, size: size ?? "",
                       brand: brandMapping,
                       fallback_pricing: pricingMapping,
                       original_price: prices.original,
                       photos: photosMapping,
                       comments: comments,
                       owner_id: nil,
                       seller_id: Int(user.id))
    }
}


struct LegacyProductModel: Codable {

    let id: Int64
    let title: String
    let description: String
    let size: String?
    let category_slug: String
    let photos: [PhotoModel]
    let default_photo: PhotoModel
    var prices: PricesModel
    let comments: CommentsModel
    var likes: LikesModel
    let brand: BrandModel
    let used: Bool
    let pro_seller: Bool
    let shipping: ShippingModel?
    let purchase_state: String
    var purchase: PurchaseModel?
    let offer: OfferModel
    var user: UserModel
    let can_sell_with_bundle: Bool
    let follow_product: Bool?
    let maximum_discount: Int
    let share_url:Foundation.URL?
    let href:String?
    let slug:String?

}

struct PricesModel: Codable {
    let original: Int
    var minimum: Int?
    var minimum_for_current_buyer: Int?
    var current: Int
    let complement: String?

    var discount : Int {
        return Int((Double(current) / Double (original)) * 100)
    }
}

struct CommentsModel: Codable {
    let available: Bool
    let total_count: Int
}

struct LikesModel: Codable {
    var total_count: Int
    var liked: Bool
}

struct BrandModel: Codable {
    let name: String?
    let slug: String?
    let image_url: String?
}

struct ShippingModel: Codable {

    enum Style : String {
        case softShipping = "soft_shipping"
        case freeShipping = "free_shipping"
        case handDeliver  = "hand_deliver"
    }

    let label: String?
    let style: String?

}

struct OfferModel: Codable {
    let available: Bool
    let unavailable_reason: String?
    let min_price: Float
    let max_price: Float
    let state: String?
    let voucher: VoucherModel?
}

struct PurchaseModel: Codable {
    let bundle_is_available: Bool
    let available: Bool
    let unavailable_reason: String?
    var release_to_buy_at: Date?
}

struct VoucherModel: Codable {
    let available: Bool
    let price: Int
    let was_counter: Bool
}



struct PriceParametersValues: Codable {
    enum TimerFormat: String, Codable {
        case hours
        case minutes
    }

    let originalPrice: Int?
    var minimumPrice: Int?
    let discount: Int?
    let tagText: String?
    let timerText: String?
    let expiresAt: Date?
    let format: TimerFormat?
    let priceSubtitle: String?
}

struct PhotoModel: Codable {

    let id: Int64?
    let filename: String?
    let selected: Bool?
    let image_public_id: String?
}

struct UserModel: Codable {
    let id: Int64
    let nickname: String
    let name: String
    let avatar: PhotoModel
    let title: String?
    let description: String?
    let city: String
    let state: String
    var followUser: Bool?
}
