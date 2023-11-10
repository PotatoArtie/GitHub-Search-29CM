//
//  GithubPlugin.swift
//  GitHub-Search-29CM
//

import Foundation

import Moya

struct GithubPlugin: PluginType {
  private let keychainService: KeychainService

  init(keychainService: KeychainService) {
    self.keychainService = keychainService
  }

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard let accessToken = self.keychainService.accessToken() else { return request }
    var request = request
    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    return request
  }
}
