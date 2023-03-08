    //
    //  Album.swift
    //  lab-tunley
    //
    //  Created by Shoaib Huq on 3/7/23.
    //

import Foundation

struct Album: Decodable {
    let artworkUrl100: URL
}

struct AlbumSearchResponse: Decodable {
    let results: [Album]
}
