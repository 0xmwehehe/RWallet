//
//  SplitScrenView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//

import SwiftUI

struct SplitView<Sidebar: View, Detail: View>: View {
    let sidebar: Sidebar
    let detail: Detail
    let sidebarWidth: CGFloat
    
    init(
        sidebarWidth: CGFloat = 380,
        @ViewBuilder sidebar: () -> Sidebar,
        @ViewBuilder detail: () -> Detail
    ) {
        self.sidebarWidth = sidebarWidth
        self.sidebar = sidebar()
        self.detail = detail()
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            sidebar
                .frame(width: sidebarWidth)
//                .background(Color(.secondarySystemBackground))
            // Detail
            Divider()
                .ignoresSafeArea()
            detail
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color(.systemBackground))
        }
//        .ignoresSafeArea()
    }
}
