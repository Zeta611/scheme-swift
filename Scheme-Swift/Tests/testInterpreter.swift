//
//  testInterpreter.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 07/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

func testInterpreter() {
  print("=== Test Interpreter ===")
  testInterpreterCanRead()
}


private func testInterpreterCanRead() {
  test("Interpreter can read") { assertion, completion in
    let input = """
      (define square (lambda (x) (* x x)))
      (define x 3)
      (square 6)
      """

    let stubIO = StubIO(input)
    let interpreter = Interpreter(input: stubIO.readLine, output: stubIO.print)
    interpreter.run(once: true)
    assertion(stubIO.output == input)
    completion()
  }
}


private class StubIO {

  var input: String
  var output: String = ""

  func readLine() -> String { return input }

  func print(item: String) {
    Swift.print(item, terminator: "", to: &output)
  }

  init(_ input: String) {
    self.input = input
  }
}
