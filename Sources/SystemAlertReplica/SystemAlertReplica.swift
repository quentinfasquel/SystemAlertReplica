//
//  SystemAlertReplica.swift
//  SystemAlertReplica
//
//  Created by Quentin Fasquel on 21/08/2023.
//

import SwiftUI

public struct SystemAlertReplica: View {
    public var title: String
    public var message: String
    public var primaryAction: String
    public var secondaryAction: String?
    fileprivate var primaryFrameGetter: ((CGRect) -> Void)?

    @Binding var primaryFrame: CGRect
    @State private var isPrimaryTruncated: Bool = false
    @State private var isSecondaryTruncated: Bool = false
    
    public init(
        title: String,
        message: String,
        primaryAction: String,
        secondaryAction: String? = nil,
        primaryFrame: Binding<CGRect> = .constant(.zero)
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self._primaryFrame = primaryFrame
        self.secondaryAction = secondaryAction
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .center, spacing: 4) {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 13))
                    .lineSpacing(0.4)
            }
            .padding(20)

            Divider()

            ConditionStack(
                isVertical: isPrimaryTruncated || isSecondaryTruncated,
                verticalSpacing: 0
            ) {
                if let secondaryAction {
                    button(title: secondaryAction, $isSecondaryTruncated)
                    Divider()
                }

                button(title: primaryAction, $isPrimaryTruncated)
                    .overlay {
                        GeometryReader { geometry in
                            Color.clear.onChange(of: geometry.frame(in: .named("alert"))) { frame in
                                primaryFrame = frame
                            }.onAppear {
                                primaryFrame = geometry.frame(in: .named("alert"))
                            }
                        }
                    }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .background(Material.thick, in: RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: 270)
        .coordinateSpace(name: "alert")
    }
    
    func button(title: String, _ isTruncated: Binding<Bool>) -> some View {
        Button(action: { }) {
            TruncableView(isTruncated: isTruncated) {
                Text(title)
                    .font(.system(size: 17))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct SystemAlertReplica_Preview: PreviewProvider {
    static var previews: some View {
        SystemAlertReplica.notificationPermission
            .environment(\.locale, .init(identifier: "fr"))
    }
}

// MARK: - System Alerts

extension Bundle {
    var displayName: String {
        (infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
    }
}

extension SystemAlertReplica {

    public static var notificationPermission: SystemAlertReplica {
        SystemAlertReplica(
            title: "alert_notification_title".localized(format: Bundle.main.displayName),
            message: "alert_notification_message".localized,
            primaryAction: "alert_notification_action_primary".localized,
            secondaryAction: "alert_notification_action_secondary".localized)
    }
}
