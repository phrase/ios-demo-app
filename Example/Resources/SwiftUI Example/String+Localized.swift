//
//  String+Localized.swift
//  Example
//
//  Copyright © 2023 Memsource GmbH. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
