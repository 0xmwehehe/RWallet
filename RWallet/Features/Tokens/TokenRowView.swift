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
            HStack{
                Circle()
                    .fill(Color(uiColor: .secondaryLabel))
                    .frame(width: 32, height: 32)
                
                // Token info: name & symbol
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(token.balance, specifier: "%.2f")")
                        .font(.headline)
                    Text(token.symbol)
                        .font(.headline)
                }
            }
            .frame(maxWidth:100, alignment: .leading)
            Spacer()
            
            // Price
//            VStack(alignment: .leading, spacing: 2) {
//                Text("$\(token.priceUSD, specifier: "%.1f")")
//                    .font(.subheadline)
//                Text("+6%")
//                    .font(.caption)
//            }
//            .frame(maxWidth: 100, alignment: .leading)
//            Spacer()
            
            
            // USD Value
            Text("$\(token.balance * token.priceUSD, specifier: "%.2f")")
                .font(.subheadline)
                .bold()
                .frame(maxWidth: 100, alignment: .trailing)
        }
    }
}
