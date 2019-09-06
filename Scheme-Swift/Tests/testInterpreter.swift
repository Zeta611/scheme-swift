//
//  testInterpreter.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 07/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

func testInterpreter() {
  testInterpreterCanRead()
}


private func testInterpreterCanRead() {
  test("Interpreter can read") { assertion, completion in
    let strings = [
      "(define square (lambda (x) (* x x)))",
      "(define x 3)",
      "(square 6)",
    ]

    let stubIO = StubIO(strings)
    let interpreter = Interpreter(input: stubIO.readLine, output: stubIO.print)
    for _ in 0..<strings.count {
      interpreter.run(once: true)
    }

    assertion(stubIO.output == strings.reversed().joined(separator: " "))
    completion()
  }
}


private class StubIO {

  var strings: [String]
  var output: String?

  func readLine() -> String { return strings.popLast() ?? "" }
  func print(item: String) { output = item }

  init(_ strings: [String]) {
    self.strings = strings
  }
}
