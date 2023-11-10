//
//  Owner.swift
//  GitHub-Search-29CM
//

import Foundation

struct Owner: Codable {
  let name: String
  let avatarUrl: URL?

  enum CodingKeys: String, CodingKey {
    case name = "login"
    case avatarUrl = "avatar_url"
  }
}
