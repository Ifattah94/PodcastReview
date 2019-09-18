//
//  FavoritePodcast.swift
//  podcastReview
//
//  Created by C4Q on 9/18/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation

struct FavoritePodcast: Codable {
    let trackId: Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl60: String
    let favoriteId: Int
    let createdAt: Int
}
