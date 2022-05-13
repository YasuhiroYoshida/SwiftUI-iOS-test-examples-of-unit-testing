//
//  QuizAppUnitTests.swift
//  QuizAppUnitTests
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import XCTest
@testable import QuizApp

class WhenLoadingAQuiz: XCTestCase {

  func testShouldMakeSureTotalPointsAreCalcularatedCorrectly() {

    let quizesDTOs = QuizData.loadQuizDTOs()
    let quizes = quizesDTOs.map(Quiz.init)
    let mathQuiz = quizes.first {
      $0.quizId == 1
    }

    XCTAssertEqual(mathQuiz!.questions.count, 3)
    XCTAssertEqual(mathQuiz!.possibleTotalPoints, 30)
  }

//  override func setUpWithError() throws {
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//  }
//
//  override func tearDownWithError() throws {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//  }
//
//  func testExample() throws {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    // Any test you write for XCTest can be annotated as throws and async.
//    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//  }
//
//  func testPerformanceExample() throws {
//    // This is an example of a performance test case.
//    measure {
//      // Put the code you want to measure the time of here.
//    }
//  }
}

class WhenCalculatingStudentGrade: XCTestCase {

  lazy var gradeASubmission: QuizSubmission = {
    var userSubmission = QuizSubmission(quizId: 1)
    userSubmission.addChoice(questionId: 1, choiceId: 2)
    userSubmission.addChoice(questionId: 2, choiceId: 3)
    userSubmission.addChoice(questionId: 3, choiceId: 4)
    return userSubmission
  }()

  lazy var gradeBSubmission: QuizSubmission = {
    var userSubmission = QuizSubmission(quizId: 1)
    userSubmission.addChoice(questionId: 1, choiceId: 1)
    userSubmission.addChoice(questionId: 2, choiceId: 3)
    userSubmission.addChoice(questionId: 3, choiceId: 4)
    return userSubmission
  }()

  lazy var gradeCSubmission: QuizSubmission = {
    var userSubmission = QuizSubmission(quizId: 1)
    userSubmission.addChoice(questionId: 1, choiceId: 4)
    userSubmission.addChoice(questionId: 2, choiceId: 2)
    userSubmission.addChoice(questionId: 3, choiceId: 1)
    return userSubmission
  }()

  func testCalculatingGradeSuccessfullyBasedOnStudentScore() {
    let quizesDTOs = QuizData.loadQuizDTOs()
    let quizes = quizesDTOs.map(Quiz.init)
    let mathQuiz = quizes.first {
      $0.quizId == 1
    }

    XCTAssertEqual(mathQuiz!.calculateLetterGrade(score: 90), "A")
    XCTAssertEqual(mathQuiz!.calculateLetterGrade(score: 89), "B")
    XCTAssertEqual(mathQuiz!.calculateLetterGrade(score: 60), "B")
    XCTAssertEqual(mathQuiz!.calculateLetterGrade(score: 59), "C")
  }

  func testCalculatingGradeSuccessfullyBasedOnStudentSubmission() {
    let quizesDTOs = QuizData.loadQuizDTOs()
    let quizes = quizesDTOs.map(Quiz.init)
    let mathQuiz = quizes.first {
      $0.quizId == 1
    }

    var studentSubmission = QuizSubmission(quizId: 1)
    studentSubmission.addChoice(questionId: 1, choiceId: 2)
    studentSubmission.addChoice(questionId: 2, choiceId: 3)
    studentSubmission.addChoice(questionId: 3, choiceId: 4)

    let gradeA = mathQuiz!.grade(submission: gradeASubmission)
    XCTAssertEqual(gradeA.letterGrade, "A")
    let gradeB = mathQuiz!.grade(submission: gradeBSubmission)
    XCTAssertEqual(gradeB.letterGrade, "B")
    let gradeC = mathQuiz!.grade(submission: gradeCSubmission)
    XCTAssertEqual(gradeC.letterGrade, "C")
  }
}
