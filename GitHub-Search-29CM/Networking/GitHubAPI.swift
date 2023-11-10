//
//  GitHubAPI.swift
//  GitHub-Search-29CM
//

import Foundation

import Moya

enum GitHubAPI {
  // Auth
  case accessToken(clientID: String, clientSecret: String, code: String)

  // Search
  case repositories(query: String, perPage: Int, page: Int)

  // My
  case myProfile
  case myStarredRepositories

  // Star & Unstar
  case star(owner: String, repository: String)
  case unstar(owner: String, repository: String)
}

extension GitHubAPI: TargetType {
  var baseURL: URL {
    switch self {
    case .accessToken:
      return URL(string: "https://github.com")!

    case .repositories, .myProfile, .myStarredRepositories, .star, .unstar:
      return URL(string: "https://api.github.com")!
    }
  }

  var path: String {
    switch self {
    case .accessToken:
      return "/login/oauth/access_token"

    case .repositories:
      return "/search/repositories"

    case .myProfile:
      return "/user"

    case .myStarredRepositories:
      return "/user/starred"

    case let .star(owner, repository):
      return "/user/starred/\(owner)/\(repository)"

    case let .unstar(owner, repository):
      return "/user/starred/\(owner)/\(repository)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .accessToken:
      return .post

    case .repositories, .myProfile, .myStarredRepositories:
      return .get

    case .star:
      return .put

    case .unstar:
      return .delete
    }
  }

  var task: Moya.Task {
    switch self {
    case let .accessToken(clientID, clientSecret, code):
      let params: [String: String] = [
        "client_id": clientID,
        "client_secret": clientSecret,
        "code": code
      ]
      return .requestParameters(parameters: params, encoding: JSONEncoding.default)

    case .repositories, .myProfile, .myStarredRepositories, .star, .unstar:
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    return ["Accept": "application/json"]
  }
}
