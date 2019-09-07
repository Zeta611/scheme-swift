//
//  Interpreter
//  Scheme-Swift
//
//  Created by Jaeho Lee on 07/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

final class Interpreter {

  var input: () -> String = { readLine() ?? "" }
  var output: (String) -> Void = { Swift.print($0) }

  private(set) var nodeArray = NodeArray()
  private(set) var symbolTable = HashTable<String, Int>(size: 97)
  private var tokenArray = [String]()


  init(input: @escaping () -> String, output: @escaping (String) -> Void) {
    self.input = input
    self.output = output
  }

  init() {}
}


extension Interpreter {

  func run(once: Bool = false) {
    repeat {
      preprocess()
      read()
      print()
    } while !once
  }
}


private extension Interpreter {

  func preprocess() {
    tokenArray = input()
      .split(separator: " ")
      .map { String($0) }
      .flatMap { (string: String) -> [String] in
        var strings = [String]()
        if string.contains("(") {
          string.split(separator: "(")
        }
        return strings
      }
  }

  func read() {
//    input()
//      .split { $0 == " " }
//      .map { String($0) }
//      .forEach {
//        if let hashValue = symbolTable.insert(key: $0, element: nil) {
//          nodeArray.append(Node(left: hashValue, right: 0))
//        }
//    }
  }


  func print() {
    let string = nodeArray
      .compactMap { symbolTable.getKey(from: $0.left) }
      .joined(separator: " ")
    output(string)
  }
}
