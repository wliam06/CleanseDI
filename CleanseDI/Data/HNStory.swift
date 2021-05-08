//
//  HNStory.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import Foundation

struct HNStory: Decodable {
    let by: String
    let descendants: Int?
    let kids: [Int]?
    let score: Int
    let time: Date
    let title: String
    let type: String
    let url: String?
}
