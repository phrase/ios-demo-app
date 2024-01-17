//
//  SwiftUIDemoView.swift
//  Example
//
//  Copyright © 2023 Memsource GmbH. All rights reserved.
//

import Foundation
import SwiftUI

struct SwiftUIDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // The Phrase OTA does not have access to the internal
                // SwiftUI translation mechanics, so NSLocalizedString must be used.
                Text(NSLocalizedString("app_name", comment: ""))
                    .font(.system(size: 20, weight: .semibold))
                // To simplify access to translations, we recommend writing an String extension
                Text("description_text".localized)
                    .font(.system(size: 16))
            }
            .padding(16)
        }
    }
}

#Preview {
    SwiftUIDemoView()
}
