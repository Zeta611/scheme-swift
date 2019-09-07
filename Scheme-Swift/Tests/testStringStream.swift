//
//  testStringStream.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 08/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

func testStringStream() {
  print("=== Test StringStream ===")
  testStringStreamCanGetCurrentCharacter()
  testStringStreamCanGetNextCharacter()
  testStringStreamCanReachItsEnd()
}


private func testStringStreamCanGetCurrentCharacter() {
  test("StringStream can get next character") { assertion, completion in
    var stream = StringStream(loremString)
    assertion(stream.get() == "L")
    completion()
  }
}


private func testStringStreamCanGetNextCharacter() {
  test("StringStream can get next character") { assertion, completion in
    var stream = StringStream(loremString)
    assertion(stream.get() == "L")
    assertion(stream.get() == "o")
    completion()
  }
}


private func testStringStreamCanReachItsEnd() {
  test("StringStream can reach its end") { assertion, completion in
    var stream = StringStream(loremString)
    var counter = 0
    let threshold = loremString.count * 2
    var character: Character?
    while !stream.isAtEnd && counter < threshold {
      character = stream.get()
      counter += 1
    }
    assertion(counter <= threshold)
    assertion(character == ".")
    assertion(stream.isAtEnd)
    completion()
  }
}


private let loremString = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Quisque risus sem, feugiat ac blandit eget, condimentum eu urna.
"""
