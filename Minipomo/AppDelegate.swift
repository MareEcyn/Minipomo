//
//  AppDelegate.swift
//  Minipomo
//
//  Created by Loki on 19.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        insertDefaultSettings()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func insertDefaultSettings() {
        let shared = UserDefaults.standard
        guard shared.value(forKey: Const.SettingsKey.initialSetup.rawValue) == nil else { return }
        
        shared.setValuesForKeys([
            Const.SettingsKey.initialSetup.rawValue: true,
            Const.SettingsKey.timeLeft.rawValue: 0,
            Const.SettingsKey.focusTimeRange.rawValue: Array(stride(from: 5, to: 121, by: 5)),
            Const.SettingsKey.smallRestTimeRange.rawValue: Array(stride(from: 5, to: 21, by: 5)),
            Const.SettingsKey.bigRestTimeRange.rawValue: Array(stride(from: 20, to: 51, by: 5)),
            Const.SettingsKey.soundAtCompletion.rawValue: true,
            Const.SettingsKey.notifyAtCompletion.rawValue: true,
            Const.SettingsKey.focusTime.rawValue: 50,
            Const.SettingsKey.smallRestTime.rawValue: 15,
            Const.SettingsKey.bigRestTime.rawValue: 30,
        ])
    }

}
