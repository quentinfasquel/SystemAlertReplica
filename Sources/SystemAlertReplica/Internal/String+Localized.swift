//
//  String+Localized.swift
//  SystemAlertReplica
//
//  Created by Quentin Fasquel on 01/08/2023.
//

import Foundation

extension String {
    func localized(format arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
     }

     var localized: String {
         return Bundle.module.localizedString(forKey: self, value: nil, table: nil)
     }
}
