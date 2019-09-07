//
//  StringStream.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 07/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

/// `StringStream` is a wrapper around `String` which focuses on accessing
/// a character one-by-one easily.
struct StringStream {

  private let string: String
  private var index: String.Index?


  init(_ string: String) {
    self.string = string
  }
}


extension StringStream {

  var isAtEnd: Bool {
    return index == string.index(before: string.endIndex)
  }


  func peek() -> Character? {
    guard !isAtEnd else { return nil }

    let peekIndex: String.Index
    if let index = index {
      peekIndex = string.index(after: index)
    } else {
      peekIndex = string.startIndex
    }
    return string[peekIndex]
  }


  mutating func get() -> Character? {
    guard !isAtEnd else { return nil }

    if let index = index {
      self.index = string.index(after: index)
    } else {
      index = string.startIndex
    }
    return string[index!]
  }
}
