//
//  OverlappingImagesView.swift
//  RWallet
//
//  Created by Rendi  on 24/12/25.
//


import SwiftUI

struct OverlappingImagesView: View {
    let images: [Image]

    let size: CGFloat
    let overlap: CGFloat

    init(
        images: [Image],
        size: CGFloat = 32,
        overlap: CGFloat = 10
    ) {
        self.images = Array(images.prefix(3)) // max 3
        self.size = size
        self.overlap = overlap
    }

    var body: some View {
        HStack(spacing: -overlap) {
            ForEach(images.indices, id: \.self) { index in
                images[index]
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .zIndex(Double(images.count + index))
            }
        }
    }
}
