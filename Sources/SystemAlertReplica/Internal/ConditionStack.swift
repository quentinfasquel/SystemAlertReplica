//
//  ConditionStack.swift
//  SystemAlertReplica
//
//  Created by Quentin Fasquel on 01/08/2023.
//

import SwiftUI

struct ConditionStack<Content: View>: View {
    var isVertical: Bool
    var horizontalAlignment = HorizontalAlignment.center
    var horizontalSpacing: CGFloat?
    var verticalAlignment = VerticalAlignment.center
    var verticalSpacing: CGFloat?
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if isVertical {
            VStack(
                alignment: horizontalAlignment,
                spacing: verticalSpacing,
                content: content
            )
        } else {
            HStack(
                alignment: verticalAlignment,
                spacing: horizontalSpacing,
                content: content
            )
        }
    }
}
