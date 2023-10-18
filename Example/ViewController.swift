//
//  ViewController.swift
//  Example
//
//  Copyright © 2023 Memsource GmbH. All rights reserved.
//

import PhraseSDK
import UIKit

class ViewController: UIViewController {

    override func loadView() {
        view = DemoView()
    }

    var demoView: DemoView {
        view as! DemoView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        demoView.backgroundColor = .white

        // By default, the bundle is swizzled, so that NSLocalizedString provides the updated translation.
        demoView.update(title: NSLocalizedString("app_name", comment: ""))

        // If swizzling has been deactivated(Info.plist -> set PhraseSDKMainBundleProxyDisabled to YES),
        // the translation can be accessed directly via Phrase SDK.
        demoView.update(description: Phrase.shared.localizedString(forKey: "description_text", value: nil, table: nil))
    }
}

