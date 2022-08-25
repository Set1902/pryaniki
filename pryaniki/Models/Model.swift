//
//  Model.swift
//  pryaniki
//
//  Created by Sergei Kovalev on 26.08.2022.
//

import Foundation
import Combine


// MARK: - Cart
struct Welcome: Decodable {
    var data: [Datum]?
    var view: [String]?
}


// MARK: - Datum
struct Datum: Decodable {
    var name: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    var text: String?
    var url: String?
    var selectedID: Int?
    var variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

// MARK: - Variant
struct Variant: Decodable {
    var id: Int?
    var text: String?
}
