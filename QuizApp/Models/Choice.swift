//
//  Choice.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import Foundation

struct Choice {
  let choiceId: Int
  let text: String
  let isCorrect: Bool

  init(choiceDTO: ChoiceDTO) {
    self.choiceId = choiceDTO.choiceId
    self.text = choiceDTO.text
    self.isCorrect = choiceDTO.isCorrect
  }
}
