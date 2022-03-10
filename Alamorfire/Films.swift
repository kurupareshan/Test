//
//  Films.swift
//  Alamorfire
//
//  Created by kurupareshan pathmanathan on 1/3/22.
//

import Foundation

struct Films: Codable {
 
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
    
}
