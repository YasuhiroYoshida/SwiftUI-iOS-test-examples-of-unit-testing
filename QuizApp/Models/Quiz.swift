//
//  Quiz.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import Foundation

struct Quiz {
  let quizId: Int
  let title: String
  let questions: [Question]

  init(quizDTO: QuizDTO) {
    self.quizId = quizDTO.quizId
    self.title = quizDTO.title
    self.questions = quizDTO.questions.map(Question.init)
  }

  var possibleTotalPoints: Int {
    questions.reduce(0) { result, question in
      result + question.point
    }
  }

  func calculateLetterGrade(score: Double) -> String {
    switch (score) {
      case 90...100:
        return "A"
      case 60...90:
        return "B"
      default:
        return "C"
    }
  }

  func grade(submission: QuizSubmission) -> Grade {
    var totalPoints = 0;

    questions.forEach { question in
      let correctChoice = question.choices.first { $0.isCorrect == true }
      let userChoiceId = submission.selectedChoices[question.questionId]
      if let correctChoice = correctChoice, let userChoiceId = userChoiceId {
        if correctChoice.choiceId == userChoiceId {
          totalPoints += question.point
        }
      }
    }

    let score = Double(totalPoints) / Double(possibleTotalPoints) * 100
    let letterGrade = calculateLetterGrade(score: score)
    return Grade(score: Int(score), letterGrade: letterGrade)
  }
}
