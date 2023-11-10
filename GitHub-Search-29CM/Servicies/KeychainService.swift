//
//  KeychainService.swift
//  GitHub-Search-29CM
//

import KeychainAccess
import RxSwift

protocol KeychainService {
  func accessToken() -> String?
  func set(_ accessToken: String)
  func removeAccessToken()
}

final class KeychainServiceImplement: KeychainService {

  // MARK: Constants

  private enum Constants {
    static let accessTokenKey = "access_token"
  }


  // MARK: Properties

  private let keychain = Keychain(service: "com.github.GitHub-Search-29CM")


  // MARK: Methods

  func accessToken() -> String? {
    guard let accessTokenValue = self.keychain[Constants.accessTokenKey] else { return nil }
    return accessTokenValue
  }

  func set(_ accessToken: String) {
    do {
      try self.keychain.set(accessToken, key: Constants.accessTokenKey)
    } catch {
      print("Keychain Log Error : \(error)")
    }
  }

  func removeAccessToken() {
    do {
      try self.keychain.remove(Constants.accessTokenKey)
    } catch {
      print("Keychain Log Error : \(error)")
    }
  }
}
