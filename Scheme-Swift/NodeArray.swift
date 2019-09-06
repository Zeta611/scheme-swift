//
//  NodeArray.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 06/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

typealias NodeArray = [Node]

struct Node {
  var left: Int
  var right: Int
}


extension Node: CustomStringConvertible {

  var description: String {
    return "(left: \(left), right: \(right))"
  }
}
