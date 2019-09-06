//
//  test.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 06/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

typealias Assertion = (Bool) -> Void
typealias Completion = () -> Void

func test(
  _ name: String,
  block: (@escaping Assertion, @escaping Completion) -> Void)
{
  var pass = true
  var assertionCount = 0

  let assert: Assertion = { value in
    assertionCount += 1
    pass = pass && value
  }

  let finish: Completion = {
    if pass {
      print("👌 \(name) passed with \(assertionCount) assertions.")
    } else {
      print("🙅‍♂️ \(name) failed with \(assertionCount) assertions.")
    }
  }

  block(assert, finish)
}
