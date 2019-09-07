//
//  testTokenizer.swift
//  Scheme-Swift
//
//  Created by Jaeho Lee on 08/09/2019.
//  Copyright © 2019 Jaeho Lee. All rights reserved.
//

import Foundation

func testTokenizer() {
  print("=== Test Tokenizer ===")
  testTokenizerCanTokenizeParentheses()
  testTokenizerCanTokenizeWhitespaces()
  testTokenizerCanTokenizeVariables()
  testTokenizerCanTokenizeNumbers()
  testTokenizerCanTokenizeMixedTokens()
}


private func testTokenizerCanTokenizeParentheses() {
  test("Tokenizer can tokenize parentheses") { assertion, completion in
    let stream = StringStream("()")
    let tokenizer = Tokenizer(stream: stream)

    let leftParenthesisToken = tokenizer.get()
    let rightParenthesisToken = tokenizer.get()

    assertion(leftParenthesisToken?.value == "(")
    assertion(leftParenthesisToken?.type == .parenthesis)

    assertion(rightParenthesisToken?.value == ")")
    assertion(rightParenthesisToken?.type == .parenthesis)

    assertion(tokenizer.get() == nil)
    completion()
  }
}


private func testTokenizerCanTokenizeWhitespaces() {
  test("Tokenizer can tokenize whitespaces") { assertion, completion in
    let whitespace = " \n  \t "

    let stream = StringStream(whitespace)
    let tokenizer = Tokenizer(stream: stream)

    let whitespaceToken = tokenizer.get()
    assertion(whitespaceToken?.value == whitespace)
    assertion(whitespaceToken?.type == .whitespace)

    assertion(tokenizer.get() == nil)
    completion()
  }
}


private func testTokenizerCanTokenizeVariables() {
  test("Tokenizer can tokenize variables") { assertion, completion in
    let variable = "a-new_variable_with-some-numbers_123_456_"

    let stream = StringStream(variable)
    let tokenizer = Tokenizer(stream: stream)

    let variableToken = tokenizer.get()
    assertion(variableToken?.value == variable)
    assertion(variableToken?.type == .variable)

    assertion(tokenizer.get() == nil)
    completion()
  }
}


private func testTokenizerCanTokenizeNumbers() {
  test("Tokenizer can tokenize numbers") { assertion, completion in
    let number = "201811974"

    let stream = StringStream(number)
    let tokenizer = Tokenizer(stream: stream)

    let numberToken = tokenizer.get()
    assertion(numberToken?.value == number)
    assertion(numberToken?.type == .number)

    assertion(tokenizer.get() == nil)
    completion()
  }
}


private func testTokenizerCanTokenizeMixedTokens() {
  test("Tokenizer can tokenize mixed tokens") { assertion, completion in
    let string = "\t (define x-4 \n(+ 3 4))"
    let expectedTokens: [Token] = [
      Whitespace(value: "\t "),
      Parenthesis(value: "("),
      Keyword(rawValue: "define")!,
      Whitespace(value: " "),
      Variable(value: "x-4"),
      Whitespace(value: " \n"),
      Parenthesis(value: "("),
      Operator(rawValue: "+")!,
      Whitespace(value: " "),
      Number(value: "3"),
      Whitespace(value: " "),
      Number(value: "4"),
      Parenthesis(value: ")"),
      Parenthesis(value: ")"),
    ]

    let stream = StringStream(string)
    let tokenizer = Tokenizer(stream: stream)

    var counter = 0
    while let token = tokenizer.get() {
      let expected = expectedTokens[counter]
      assertion(token.type == expected.type)
      assertion(token.value == expected.value)
      counter += 1
    }

    completion()
  }
}
