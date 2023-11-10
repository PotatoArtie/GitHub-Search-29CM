//
//  AppDelegate.swift
//  GitHub-Search-29CM
//

import UIKit

import Moya
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: Properties

  private let keychainService: KeychainService
  private let gitHubLoginService: GitHubLoginService

  var window: UIWindow?


  // MARK: Initializing

  override init() {
    // Shared
    self.keychainService = KeychainServiceImplement()

    // Networking
    let gitHubPlugin = GithubPlugin(keychainService: self.keychainService)
    let gitHubAPIProvider = MoyaProvider<GitHubAPI>(plugins: [gitHubPlugin])

    // Service
    self.gitHubLoginService = GitHubLoginServiceImplement(
      gitHubAPIProvider: gitHubAPIProvider,
      keychainService: self.keychainService
    )
    super.init()
  }


  // MARK: Application

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Configure Window
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = MainNavigationController(
      gitHubLoginViewControllerFactory: {
        return GitHubLoginViewController(
          gitHubLoginService: self.gitHubLoginService
        )
      }
    )
    self.window?.makeKeyAndVisible()
    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    if url.absoluteString.contains("login") {
      return self.gitHubLoginService.handle(url)
    } else {
      return true
    }
  }
}
