//
//  NFTDetailView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct NFTDetailView: View {
    let token: NFTModel
    var body: some View {
        BaseDetailView {
            ScrollView {
                VStack(alignment:.leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemFill))
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Text("NFT")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        )
                    Text(token.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Divider()
                    VStack (spacing: 24) {
                        HStack {
                            Text("Collection")
                            Spacer()
                            Text(token.collection)
                                .bold()
                        }
                        HStack {
                            Text("Chain")
                            Spacer()
                            Text(token.chain)
                                .bold()
                        }
                        HStack {
                            Text("Collection floor")
                            Spacer()
                            Text("-")
                                .bold()
                        }
                        HStack {
                            Text("Rarity")
                            Spacer()
                            Text("\(token.rarityRank ?? 0)")
                                .bold()
                        }
                        HStack {
                            Text("Last price")
                            Spacer()
                            Text("\(token.lastSale ?? 0)")
                                .bold()
                        }
                        
                    }
                }
                .padding()
            }
            HStack{
                Button {
                    // transfer
                } label: {
                    Text("Send")
                        .frame(maxWidth:.infinity)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    // transfer
                } label: {
                    Text("Listing")
                        .frame(maxWidth:.infinity)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NFTDetailView(token: NFTModel(id: "1", name: "Warplet #1039899", imageURL: "", collection:"Warplet Blind Box", chain: "Base", rarityRank: 0, lastSale:0))
}
