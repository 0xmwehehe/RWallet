//
//  DAppGridView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct DAppGridView: View {
    let apps: [DAppModel]
    let onSelect: (DAppModel) -> Void

    let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(apps) { app in
                Button {
                    onSelect(app)
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: app.icon)
                            .font(.system(size: 28))
                            .frame(width: 56, height: 56)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        
                        Text(app.name)
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

//#Preview {
//    DAppGridView()
//}
