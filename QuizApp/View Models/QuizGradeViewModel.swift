//
//  GradeViewModel.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 10/22/21.
//

import Foundation

class QuizGradeViewModel: ObservableObject {

  @Published var gradeViewModel: GradeViewModel?
  var networkService: NetworkService

  init(networkService: NetworkService) {
    self.networkService = networkService
  }

  func submitQuiz(submission: QuizSubmission) {

    networkService.getQuizById(url: Constants.Urls.quizById(submission.quizId)) { result in
      switch result {
        case .success(let quizDTO):
          let quiz = Quiz(quizDTO: quizDTO)
          let grade = quiz.grade(submission: submission)
          DispatchQueue.main.async {
            self.gradeViewModel = GradeViewModel(grade: grade)
          }
          print(quizDTO)
        case .failure(let error):
          print(error)
      }
    }
  }
}


