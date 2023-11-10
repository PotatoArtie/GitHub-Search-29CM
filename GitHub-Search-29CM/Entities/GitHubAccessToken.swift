//
//  GitHubAccessToken.swift
//  GitHub-Search-29CM
//

import Foundation

struct GitHubAccessToken: Codable {
  let value: String
  
  enum CodingKeys: String, CodingKey {
    case value = "access_token"
  }
}
