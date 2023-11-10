//
//  Repository.swift
//  GitHub-Search-29CM
//

import Foundation

struct Repository: Codable {
  let id: Int
  let name: String
  let fullName: String?
  let description: String?
  let starCount: Int?
  let language: String?
  let owner: Owner

  enum CodingKeys: String, CodingKey {
    case id, name, description, owner, language
    case fullName = "full_name"
    case starCount = "stargazers_count"
  }
}
