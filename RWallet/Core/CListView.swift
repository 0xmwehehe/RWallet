//
//  CListView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct CListView<Item: Identifiable & Equatable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content
    
    @State private var selectedItem: Item? = nil
    
    init(items: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items) { item in
                    content(item)
                        .foregroundStyle(selectedItem == item ?
                                         Color(uiColor: .systemBackground) :
                                            Color(uiColor: .label))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(
                            selectedItem == item ?
                            Color.accentColor :
                                Color(uiColor: .systemBackground)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedItem == item {
                                selectedItem = nil
                            } else {
                                selectedItem = item
                            }
                        }
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    AssetsView()
}
