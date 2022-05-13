//
//  Question.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import Foundation

struct Question {
  let questionId: Int
  let text: String
  let point: Int
  let choices: [Choice]

  init(questionDTO: QuestionDTO) {
    self.questionId = questionDTO.questionId
    self.text = questionDTO.text
    self.point = questionDTO.point
    self.choices = questionDTO.choices.map(Choice.init)
  }
}
