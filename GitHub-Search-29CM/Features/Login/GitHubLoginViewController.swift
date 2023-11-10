//
//  GitHubLoginViewController.swift
//  GitHub-Search-29CM
//

import Foundation
import SafariServices

final class GitHubLoginViewController: SFSafariViewController {

  // MARK: Properties

  private var gitHubLoginService: GitHubLoginService


  // MARK: Initializing

  init(gitHubLoginService: GitHubLoginService) {
    self.gitHubLoginService = gitHubLoginService
      
    let url = Self.gitHubLoginURL()
    let configuration = SFSafariViewController.Configuration()
    super.init(url: url, configuration: configuration)
    self.modalPresentationStyle = .pageSheet
    self.gitHubLoginService.delegate = self
  }

  private static func gitHubLoginURL() -> URL {
    let clientID = GitHubLoginServiceImplement.Constants.clientID
    let urlString = 
      clientID.isEmpty ? "https://github.com/login/oauth/authorize" :
      "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=public_repo"
    return URL(string: urlString)!
  }
}


// MARK: GitHubLoginServiceDelegate

extension GitHubLoginViewController: GitHubLoginServiceDelegate {
  func loginDidSuccess() {
    self.dismiss(animated: true)
  }
}
