//
//  CategoryModel.swift
//  TummocTask
//
//  Created by gokul on 06/08/24.
//

import Foundation

//{
//  "status": true,
//  "message": "Product Categories",
//  "error": null,
//  "categories": [
//    {
//      "id": 55,
//      "name": "Food",
//      "items": [
//        {
//          "id": 5501,
//          "name": "Potato Chips",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553691.png",
//          "price": 40.00
//        },
//        {
//          "id": 5502,
//          "name": "Penne Pasta",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553691.png",
//          "price": 110.40
//        },
//        {
//          "id": 5503,
//          "name": "Tomato Ketchup",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553691.png",
//          "price": 80.00
//        },
//        {
//          "id": 5504,
//          "name": "Nutella Spread",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553691.png",
//          "price": 120.00
//        },
//        {
//          "id": 5505,
//          "name": "Everyday Granola",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553691.png",
//          "price": 450.00
//        }
//      ]
//    },
//    {
//      "id": 56,
//      "name": "Beverages",
//      "items": [
//        {
//          "id": 5601,
//          "name": "Orange Fanta 1 Litre",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2405/2405479.png",
//          "price": 100.00
//        },
//        {
//          "id": 5602,
//          "name": "Keventers Thick Shake 60 ml",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2405/2405479.png",
//          "price": 79.99
//        },
//        {
//          "id": 5603,
//          "name": "Fresh Jaljeera",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2405/2405479.png",
//          "price": 50.00
//        }
//      ]
//    },
//    {
//      "id": 57,
//      "name": "Hygiene Essentials",
//      "items": [
//        {
//          "id": 5701,
//          "name": "Clear Baby Shampoo",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553642.png",
//          "price": 300.00
//        },
//        {
//          "id": 5702,
//          "name": "Walnut Scrub Daily Glow",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553642.png",
//          "price": 165.00
//        },
//        {
//          "id": 5703,
//          "name": "Shine Detergent Powder 1 kg",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553642.png",
//          "price": 300.00
//        },
//        {
//          "id": 5704,
//          "name": "All-in-one Cleaner",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553642.png",
//          "price": 90.00
//        },
//        {
//          "id": 5705,
//          "name": "Soft Tissue Box",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553642.png",
//          "price": 40.00
//        },
//        {
//          "id": 5706,
//          "name": "Aroma Essence Balls 10 Pieces",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553642.png",
//          "price": 200.00
//        }
//      ]
//    },
//    {
//      "id": 58,
//      "name": "Pooja Daily Needs",
//      "items": [
//        {
//          "id": 5801,
//          "name": "Camphor Large",
//          "icon": "https://cdn-icons-png.flaticon.com/128/7096/7096435.png",
//          "price": 40.00
//        },
//        {
//          "id": 5802,
//          "name": "Mix Fresh Flowers",
//          "icon": "https://cdn-icons-png.flaticon.com/128/7096/7096435.png",
//          "price": 80.00
//        },
//        {
//          "id": 5803,
//          "name": "Sandalwood Incense Sticks",
//          "icon": "https://cdn-icons-png.flaticon.com/128/7096/7096435.png",
//          "price": 90.00
//        },
//        {
//          "id": 5804,
//          "name": "Premium Candle Pack of 10",
//          "icon": "https://cdn-icons-png.flaticon.com/128/7096/7096435.png",
//          "price": 400.00
//        }
//      ]
//    },
//    {
//      "id": 59,
//      "name": "Electronic Items",
//      "items": [
//        {
//          "id": 5901,
//          "name": "USB Cable Type C",
//          "icon": "https://cdn-icons-png.flaticon.com/128/3659/3659899.png",
//          "price": 200.00
//        },
//        {
//          "id": 5902,
//          "name": "HearSense Bluetooth Speaker",
//          "icon": "https://cdn-icons-png.flaticon.com/128/3659/3659899.png",
//          "price": 3500.00
//        },
//        {
//          "id": 5903,
//          "name": "Smartwatch Black NewGen",
//          "icon": "https://cdn-icons-png.flaticon.com/128/3659/3659899.png",
//          "price": 6500.00
//        }
//      ]
//    }
//  ]
//}
//shopping.json
//Displaying shopping.json.
//status": true,
//  "message": "Product Categories",
//  "error": null,
//  "categories":
//{
//      "id": 55,
//      "name": "Food",
//      "items": [
//        {
//          "id": 5501,
//          "name": "Potato Chips",
//          "icon": "https://cdn-icons-png.flaticon.com/128/2553/2553691.png",
//          "price": 40.00
//        },
struct CategoryModel : Codable{
    var status : Bool
    var message : String
    var categories : [St_CategoryModel]
}
struct St_CategoryModel : Codable{
    var id : Int
    var name : String
    var items : [St_items]
}
struct St_items : Codable {
    var id : Int
    var name : String
    var icon : String
    var price : Double
}
