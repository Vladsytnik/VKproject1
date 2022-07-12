//
//  Model.swift
//  vk
//
//  Created by Vlad Sytnik on 12.07.2022.
//

import Foundation
import UIKit

struct Model: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}

struct Service: Codable {
    let name: String
    let serviceDescription: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case serviceDescription = "description"
        case link
        case iconURL = "icon_url"
    }
}



