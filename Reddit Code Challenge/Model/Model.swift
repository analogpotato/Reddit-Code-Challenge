//
//  Model.swift
//  Reddit Code Challenge
//
//  Created by Frank Foster on 8/18/20.
//  Copyright © 2020 Frank Foster. All rights reserved.
//

import Foundation

struct Model: Decodable {
    let kind: String
    let data: ListingData
}

struct ListingData: Decodable {
    let after: String
    let before: String?
    let children: [Post]
    let dist: Int
    let modhash: String
}

struct PostData: Decodable {
    let title: String?
    let subreddit: String?
    let score: Int
    let url: URL
}

struct Post: Decodable {
    let data: PostData
    let kind: String?
}







