//
//  SystemAlertReplicaModifier.swift
//  SystemAlertReplica
//
//  Created by Quentin Fasquel on 21/08/2023.
//

import SwiftUI

struct SystemAlertReplicaModifier<Overlay: View>: ViewModifier {
    var alert: SystemAlertReplica
    var overlay: (CGRect) -> Overlay
    
    @State private var primaryFrame: CGRect = .zero
    
    init(title: String,
         message: String,
         primaryAction: String,
         secondaryAction: String? = nil,
         overlay: @escaping (CGRect) -> Overlay
    ) {
        self.overlay = overlay
        self.alert = SystemAlertReplica(
            title: title,
            message: message,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction)
    }
    
    init(alert: SystemAlertReplica, overlay: @escaping (CGRect) -> Overlay) {
        self.overlay = overlay
        self.alert = SystemAlertReplica(
            title: alert.title,
            message: alert.message,
            primaryAction: alert.primaryAction,
            secondaryAction: alert.secondaryAction)
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            Color.clear.ignoresSafeArea().overlay {
                SystemAlertReplica(
                    title: alert.title,
                    message: alert.message,
                    primaryAction: alert.primaryAction,
                    secondaryAction: alert.secondaryAction,
                    primaryFrame: $primaryFrame
                )
                .overlay {
                    overlay(primaryFrame)
                }
            }
        }
    }
}

// MARK: - Presenter

extension View {

    public func alertReplica(
        title: String,
        message: String,
        primaryAction: String,
        secondaryAction: String? = nil
    ) -> some View {
        modifier(SystemAlertReplicaModifier(
            title: title,
            message: message,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction,
            overlay: { _ in EmptyView() }))
    }

    public func alertReplica(_ alert: SystemAlertReplica) -> some View {
        modifier(SystemAlertReplicaModifier(alert: alert, overlay: { _ in EmptyView() }))
    }

    public func alertReplica(_ alert: SystemAlertReplica, @ViewBuilder overlay: @escaping ((CGRect) -> some View)) -> some View {
        modifier(SystemAlertReplicaModifier(alert: alert, overlay: overlay))
    }
}
