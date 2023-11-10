//
//  GitHubLoginService.swift
//  GitHub-Search-29CM
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

protocol GitHubLoginServiceDelegate: AnyObject {
  func loginDidSuccess()
}

protocol GitHubLoginService {
  var delegate: GitHubLoginServiceDelegate? { get set }

  func handle(_ url: URL) -> Bool
}

final class GitHubLoginServiceImplement: GitHubLoginService {

  // MARK: Constants

  enum Constants {
    static let clientID = ""
    static let clientSecret = ""
  }


  // MARK: Properties

  private let gitHubAPIProvider: MoyaProvider<GitHubAPI>
  private let keychainService: KeychainService
  weak var delegate: GitHubLoginServiceDelegate?


  // MARK: Initializing

  init(gitHubAPIProvider: MoyaProvider<GitHubAPI>, keychainService: KeychainService) {
    self.gitHubAPIProvider = gitHubAPIProvider
    self.keychainService = keychainService
  }


  // MARK: Handle URL

  func handle(_ url: URL) -> Bool {
    guard let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return false }
    guard let queryItems = urlComponent.queryItems else { return false }
    guard let clientCode = queryItems.first(where: { $0.name == "code" })?.value else { return false }
    self.processLoginSuccess(clientCode)
    return true
  }

  private func processLoginSuccess(_ clientCode: String) {
    _ = self.accessToken(clientID: Constants.clientID, clientSecret: Constants.clientSecret, code: clientCode)
      .asObservable()
      .subscribe(onNext: { [weak self] accessToken in
        self?.keychainService.set(accessToken.value)
        self?.delegate?.loginDidSuccess()
        print("accessToken: \(accessToken)")
      })
  }

  private func accessToken(clientID: String, clientSecret: String, code: String) -> Single<GitHubAccessToken> {
    return self.gitHubAPIProvider.rx.request(GitHubAPI.accessToken(
        clientID: clientID,
        clientSecret: clientSecret,
        code: code
      ))
      .filterSuccessfulStatusCodes()
      .map { response -> GitHubAccessToken in
        do {
          let gitHubAccessToken = try JSONDecoder().decode(GitHubAccessToken.self, from: response.data)
          return gitHubAccessToken
        } catch {
          throw MoyaError.jsonMapping(response)
        }
      }
  }
}
