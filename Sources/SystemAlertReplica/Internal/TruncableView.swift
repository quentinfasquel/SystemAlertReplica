//
//  TruncableView.swift
//  SystemAlertReplica
//
//  Created by Quentin Fasquel on 21/08/2023.
//

import SwiftUI

struct TruncableView<Content: View>: View {
    @Binding var isTruncated: Bool
    @ViewBuilder var content: () -> Content
    
    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero
    
    var body: some View {
        content()
            .lineLimit(1)
            .readSize { size in
                truncatedSize = size
            }
            .background(
                content()
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                    }
            )
            .onAppear {
                updateValue()
            }
    }
    
    func updateValue() {
        if truncatedSize != .zero, intrinsicSize != .zero {
            isTruncated = truncatedSize != intrinsicSize
        }
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
