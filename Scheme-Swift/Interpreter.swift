//
//  Interpreter
//  Scheme-Swift
//
//  Created by Jaeho Lee on 07/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

struct Interpreter {

  private var nodeArray = NodeArray()
  private var symbolTable = HashTable<String, Int>(size: 97)

  var input: () -> String = { readLine() ?? "" }
  var output: (String) -> Void = { Swift.print($0) }


  init(input: @escaping () -> String, output: @escaping (String) -> Void) {
    self.input = input
    self.output = output
  }

  init() {}
}


extension Interpreter {

  mutating func run(once: Bool = false) {
    repeat {
      read()
      print()
    } while !once
  }
}


private extension Interpreter {

  mutating func read() {
    input()
      .split { $0 == " " }
      .map { String($0) }
      .forEach {
        if let hashValue = symbolTable.insert(key: $0, element: nil) {
          nodeArray.append(Node(left: hashValue, right: 0))
        }
    }
  }


  func print() {
    let string = nodeArray
      .compactMap { symbolTable.getKey(from: $0.left) }
      .joined(separator: " ")
    output(string)
  }
}
