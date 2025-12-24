//
//  BaseDetailView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct BaseDetailView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .toolbar(.hidden, for: .tabBar)
    }
}
