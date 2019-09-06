//
//  HashTable.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 06/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

struct HashTable<Key: LosslessStringConvertible & Equatable, Element> {

  private let size: Int
  private var table = [Bucket]()

  private(set) var count = 0

  init(size: Int) {
    self.size = size
    table.reserveCapacity(size)
    table = [Bucket](
      repeating: Bucket(key: nil, element: nil),
      count: size)
  }
}


extension HashTable {

  /// Gets the element for the given `key`.
  ///
  /// - Parameter key: The key to find in the hash table.
  /// - Returns: The element associated with `key` if `key` is in the hash
  ///   table; otherwise, `nil`.
  /// - Complexity: O(1) expected, worst case O(*n*), where *n* is the size of
  ///   the hash table.
  func get(from key: Key) -> Element? {
    let hashValue = hash(of: key)

    for i in 0..<size {
      let index = (hashValue + i) % size
      let bucket = table[index]

      guard let keyToCheck = bucket.key else {
        // The element for the key doesn't exist in the contiguous buckets
        // from the home bucket.
        return nil
      }

      // The element is found.
      if keyToCheck == key {
        return bucket.element
      }
    }
    // The hash table is full, but the key doesn't exist.
    return nil
  }


  /// Inserts the pair `(key, element)` to the hash table.
  ///
  /// - Parameters:
  ///   - key: The key associated with `element` to add to the hash table.
  ///   - element: The element to add to the hash table.
  /// - Returns: `true` if insertion was successful, `false` otherwise.
  /// - Complexity: O(1) expected, worst case O(*n*), where *n* is the size of
  ///   the hash table.
  @discardableResult
  mutating func insert(key: Key, element: Element) -> Bool {
    let hashValue = hash(of: key)

    for i in 0..<size {
      let index = (hashValue + i) % size
      let bucket = table[index]

      if bucket.key == nil {
        setElement(element, forKey: key, at: index)
        count += 1
        return true
      }
    }
    return false
  }


  @discardableResult
  mutating func delete(from key: Key) -> Bool {
    fatalError("delete(from:) is not implemented.")
  }
}


private extension HashTable {

  struct Bucket {
    var key: Key?
    var element: Element!
  }


  func hash(of value: LosslessStringConvertible) -> Int {
    return value.description
      .unicodeScalars
      .map { Int($0.value) }
      .reduce(0, +)
  }


  mutating func setElement(
    _ element: Element,
    forKey key: Key,
    at index: Int)
  {
    table[index].key = key
    table[index].element = element
  }
}
