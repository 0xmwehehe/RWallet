//
//  NFTViewModel.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import Foundation

class NFTViewModel: ObservableObject {
    @Published var tokens: [NFTModel] = [
        NFTModel(id: "1", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "2", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "3", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "4", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "5", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "6", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "7", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
        NFTModel(id: "8", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0),
    ]
    
    // Optional: bisa simpan selected token di ViewModel juga
    @Published var selectedToken: NFTModel?
    
    // Fungsi untuk select first token otomatis
    func selectFirstToken() {
        if selectedToken == nil {
            selectedToken = tokens.first
        }
    }
}
