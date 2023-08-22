//
//  B_LineApp.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-11.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct B_LineApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var stopViewModel = StopsViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(stopViewModel)
        }
    }
}
