//
//  ContentView.swift
//  Example
//
//  Created by Quentin Fasquel on 21/08/2023.
//

import SwiftUI
import SystemAlertReplica

struct ContentView: View {
    var body: some View {
        VStack {

        }
        .padding()
        .alertReplica(.notificationPermission) { rect in
            RoundedRectangle(cornerRadius: 10)
                .frame(width: rect.width, height: rect.height)
                .position(x: rect.midX, y: rect.midY)
                .foregroundStyle(.red)
                .opacity(0.2)
        }

    }
}

#Preview {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}
