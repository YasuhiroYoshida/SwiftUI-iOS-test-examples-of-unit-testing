//
//  MockNetworkService.swift
//  QuizAppUITests
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import Foundation

class MockNetworkService: NetworkService {
  func getAllQuizes(url: URL, completion: @escaping (Result<[QuizDTO], NetworkError>) -> Void) {
    let quizDTOs = QuizData.loadQuizDTOs()
    completion(.success(quizDTOs))
  }

  func getQuizById(url: URL, completion: @escaping (Result<QuizDTO, NetworkError>) -> Void) {
    let quizDTOs = QuizData.loadQuizDTOs()
    let quizDTO = quizDTOs.first {
      $0.quizId == 1
    }
    completion(.success(quizDTO!))
  }
}
