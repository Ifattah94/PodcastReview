//
//  PodcastInfo.swift
//  podcastReview
//
//  Created by C4Q on 9/18/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
struct PodcastInfo: Codable {
    let results: [Podcast]
}

struct Podcast: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl60: String
}
