//
//  QuizAppUITests.swift
//  QuizAppUITests
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import XCTest

class WhenAppISLaunched: XCTestCase {


  func testShouldDisplayAvailableQuizes() {
    let app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    continueAfterFailure = false
    app.launch()

    let quizzesListTable = app.tables["quizzesList"]

    XCTAssertEqual(quizzesListTable.cells.count, 2)
  }
//  override func setUpWithError() throws {
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//
//    // In UI tests it is usually best to stop immediately when a failure occurs.
//    continueAfterFailure = false
//
//    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//  }
//
//  override func tearDownWithError() throws {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//  }
//
//  func testExample() throws {
//    // UI tests must launch the application that they test.
//    let app = XCUIApplication()
//    app.launch()
//
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//  }
//
//  func testLaunchPerformance() throws {
//    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//      // This measures how long it takes to launch your application.
//      measure(metrics: [XCTApplicationLaunchMetric()]) {
//        XCUIApplication().launch()
//      }
//    }
//  }
}

class WhenUserTapsAQuiz: XCTestCase {

  func testShouldNavigateToListOfQuestions() {
    let app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    continueAfterFailure = false
    app.launch()

    let quizzesListTable = app.tables["quizzesList"]
    quizzesListTable.cells["Math 101"].tap()

    let _ = app.tables["questionsList"].waitForExistence(timeout: 2.0)

    XCTAssertEqual(app.tables["questionsList"].cells.count, 3)
  }
}

class WhenUserSubmitQuizWithoutAnsweringAllQuestions: XCTestCase {

  func testShouldDisplayErrorMessage() {
    let app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    continueAfterFailure = false
    app.launch()

    let quizzesListTable = app.tables["quizzesList"]
    quizzesListTable.cells["Math 101"].tap()

    let _ = app.tables["questionsList"].waitForExistence(timeout: 2.0)

    app.buttons["submitQuizButton"].tap()

    XCTAssertEqual(app.staticTexts["messageText"].label, Constants.Messages.quizSubmissonFailed)
  }
}

class WhenUserSubmitsQuiz: XCTestCase {

  func testShouldNavigateToTheGrade() {
    let app = XCUIApplication()
    app.launchEnvironment = ["ENV": "TEST"]
    continueAfterFailure = false
    app.launch()

    let quizzesListTable = app.tables["quizzesList"]
    quizzesListTable.cells["Math 101"].tap()

    var _ = app.tables["questionsList"].waitForExistence(timeout: 2.0)

    let questionsListTable = app.tables["questionsList"]
    questionsListTable.cells["1, What is 2+2?, Square, 3, Square, 4, Square, 22, Square, 6"].descendants(matching: .image).element(boundBy: 1).tap()
    questionsListTable.cells["2, What is 5+2?, Square, 3, Square, 4, Square, 7, Square, 6"].descendants(matching: .image).element(boundBy: 2).tap()
    questionsListTable.cells["3, What is 10+5?, Square, 3, Square, 4, Square, 7, Square, 15"].descendants(matching: .image).element(boundBy: 3).tap()

    app.buttons["submitQuizButton"].tap()

    XCTAssertTrue(app.staticTexts["A"].waitForExistence(timeout: 2.0))
  }
}
