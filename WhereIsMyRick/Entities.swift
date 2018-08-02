//
//  Entities.swift
//  WhereIsMyRick
//
//  Created by Denis Bogomolov on 02/08/2018.
//  Copyright © 2018 showmax. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let name: String
    let image: URL
}

struct Response: Decodable {
    let results: [Character]?
}
