//
//  ItemModel.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 4/26/25.
//

import UIKit


struct ItemModel {
    let itemImage: UIImage
    let name: String
    let price: String
    var heartIsSelected: Bool
}

extension ItemModel {
    static func dummy() -> [ItemModel] {
            return [
                ItemModel(itemImage: .product1, name: "퉁퉁퉁사후르", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product2, name: "오쏘몰", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product3, name: "애플워치", price: "5000", heartIsSelected: true),
                ItemModel(itemImage: .product4, name: "가방", price: "5000", heartIsSelected: true),
                ItemModel(itemImage: .product5, name: "헤드셋", price: "5000", heartIsSelected: true),
                ItemModel(itemImage: .product6, name: "틴트", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product7, name: "카메라", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product8, name: "로션", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product1, name: "락스", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product4, name: "가방", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product5, name: "헤드셋", price: "5000", heartIsSelected: false),
                ItemModel(itemImage: .product6, name: "틴트", price: "5000", heartIsSelected: false)
            ]
        }
}
