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
    let string = "define x 3"
    let stubIO = StubIO(string)
    var interpreter = Interpreter(input: stubIO.readLine, output: stubIO.print)
    interpreter.run(once: true)
    assertion(stubIO.output == string)
    completion()
  }
}


private class StubIO {

  var value: String
  var output: String?

  func readLine() -> String { return value }
  func print(item: String) { output = item }

  init(_ value: String) {
    self.value = value
  }
}
