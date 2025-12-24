//
//  NFTModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

struct NFTModel: Identifiable, Hashable {
    let id: String              // tokenId / unique id
    let name: String            // "Warplet #1039899"
    let imageURL: String
    let collection: String
    let chain: String
    let rarityRank: Int?
    let lastSale: Double?
}
