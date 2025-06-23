//
//  AppDelegate.swift
//  Example
//
//  Copyright © 2023 Memsource GmbH. All rights reserved.
//

import os
import PhraseSDK
import UIKit

private let subsystem = "com.phrase.AppDelegate"
private let logger = Logger(subsystem: subsystem, category: "LogMessages")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // We don't initialize the OTA SDK in the case of previews, as these are updated very frequently.
        if !isPreview {
            setupPhrase()
            updateTranslations()
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    private func setupPhrase() {
        // Enables info log messages (optional)
        Phrase.shared.configuration.debugMode = true
        // Set a timeout for the requests against Phrase. The default timeout is 10 seconds.
        Phrase.shared.configuration.timeout = TimeInterval(20)
        // If needed change to US data center
        // Phrase.shared.configuration.apiHost = .us

        // Important: Finish the configuration before calling setup
        Phrase.shared.setup(
            distributionID: "<distributionID>",
            environmentSecret: "<environmentSecret>"
        )
    }

    private func updateTranslations() {
        Task {
            do throws(PhraseUpdateError) {
                let updated = try await Phrase.shared.updateTranslation()
                if updated {
                    // Activate latest updates
                    Phrase.shared.applyPendingUpdates()
                    // re-render your UI if needed
                    logger.info("translations changed")
                } else {
                    logger.debug("translations remain unchanged")
                }
            } catch {
                switch error.last {
                case let PhraseNetworkError.connectionError(underlyingError) as PhraseNetworkError:
                    logger.error("Connection Error: \(underlyingError.localizedDescription)")
                case let PhraseNetworkError.responseStatusInvalid(code, message) as PhraseNetworkError:
                    logger.error("Response Status Invalid: \(code) \(message)")
                default:
                    logger.error("A error occurred while updating the translations \(error.last?.localizedDescription ?? "")")
                }
            }
        }
    }

}

