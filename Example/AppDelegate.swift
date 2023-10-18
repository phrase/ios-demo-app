//
//  AppDelegate.swift
//  Example
//
//  Copyright © 2023 Memsource GmbH. All rights reserved.
//

import os
import PhraseSDK
import UIKit

private let subsystem = "com.example.AppDelegate"
private let logger = Logger(subsystem: subsystem, category: "LogMessages")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        setupPhrase()
        updateTranslations()

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

        Phrase.shared.setup(
            distributionID: "<distributionID>",
            environmentSecret: "<environmentSecret>"
        )
    }

    private func updateTranslations() {
        do {
            try Phrase.shared.updateTranslation { result in
                switch result {
                case let .success(translationChanged):
                    if translationChanged {
                        // If a translation was used before the update was completed,
                        // the translations will only be available after restarting the app,
                        // otherwise the new translations will be used directly.
                        logger.info("translations changed")
                    } else {
                        logger.error("translations remain unchanged")
                    }

                case let .failure(error):
                    switch error.last {
                    case let PhraseNetworkError.connectionError(underlyingError) as PhraseNetworkError:
                        logger.error("Connection Error: \(underlyingError.localizedDescription)")
                    case let PhraseNetworkError.responseStatusInvalid(code, message) as PhraseNetworkError:
                        debugPrint("Response Status Invalid: \(code) \(message)")
                    default:
                        logger.error("An error occured while updating the translations \(error.last?.localizedDescription ?? "")")
                    }
                }
            }
        } catch PhraseSetupError.notInitialized {
            logger.error("Setup method has not been called yet.")
        } catch PhraseSetupError.missingDistributionID {
            logger.error("An empty distribution ID has been given.")
        } catch PhraseSetupError.missingEnvironmentSecret {
            logger.error("An empty environment secret has been given.")
        } catch PhraseSetupError.appVersionNotSemantic(underlyingError: let error) {
            logger.error("The App version is not semantic. \(error.localizedDescription)")
        } catch {
            logger.error("unexpected error")
        }
    }

}

