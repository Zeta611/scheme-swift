//
//  testHashTable.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 06/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

func testHashTable() {
  testHashTableCanInsert()
  testHashTableCanGet()
  testHashTableCanCount()
  testHashTableCanBeFull()
  testHashTableCanOverflow()
}


private func testHashTableCanInsert() {
  test("HashTable can insert") { assertion, completion in
    let size = 13
    var table = HashTable<String, String>(size: size)
    assertion(table.insert(key: "key", element: "element"))
    completion()
  }
}


private func testHashTableCanGet() {
  test("HashTable can get") { assertion, completion in
    let size = 13
    var table = HashTable<String, String>(size: size)
    let (key, element) = ("key", "element")
    assertion(table.insert(key: key, element: element))
    assertion(table.get(from: key) == element)
    completion()
  }
}


private func testHashTableCanCount() {
  test("HashTable can count") { assertion, completion in
    let size = 13
    let count = 5
    var table = HashTable<String, String>(size: size)

    for i in 1...count {
      let (key, element) = ("key \(i)", "element \(i)")
      table.insert(key: key, element: element)
      assertion(i == table.count)
    }
    completion()
  }
}


private func testHashTableCanBeFull() {
  test("HashTable can be full") { assertion, completion in
    let size = 13
    let count = 13
    var table = HashTable<String, String>(size: size)

    for i in 1...count {
      let (key, element) = ("key \(i)", "element \(i)")
      assertion(table.insert(key: key, element: element))
      assertion(table.get(from: key) == element)
    }
    completion()
  }
}


private func testHashTableCanOverflow() {
  test("HashTable can be overflow") { assertion, completion in
    let size = 13
    let count = 13
    var table = HashTable<String, String>(size: size)

    for i in 1...count {
      let (key, element) = ("key \(i)", "element \(i)")
      assertion(table.insert(key: key, element: element))
      assertion(table.get(from: key) == element)
    }

    for i in 1...count {
      let (key, element) = ("new key \(i)", "new element \(i)")
      assertion(!table.insert(key: key, element: element))
      assertion(table.get(from: key) != element)
    }
    completion()
  }
}
