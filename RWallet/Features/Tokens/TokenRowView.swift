//
//  TokenRowView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct TokenRowView: View {
    let token: TokenModel
    
    var body: some View {
        HStack(alignment:.center) {
            // Icon (placeholder)
            HStack(spacing:20){
                ImageOverlayView(
                    mainImage: Image(token.image),
                    overlayImage: Image(token.chain)
                )
                
                // Token info: name & symbol
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(token.balance, specifier: "%.2f")")
                        .font(.headline)
                    Text(token.symbol)
                        .font(.headline)
                }
            }
            Spacer()
            
            
            // USD Value
            Text("$ \(token.balance * token.priceUSD, specifier: "%.2f")")
                .font(.subheadline)
                .bold()
        }
    }
}
