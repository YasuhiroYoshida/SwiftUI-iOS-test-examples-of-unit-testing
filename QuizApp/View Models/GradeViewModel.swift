//
//  GradeViewModel.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 2022-05-13.
//

import Foundation

struct GradeViewModel {
  let grade: Grade

  var letter: String {
    self.grade.letterGrade
  }

  var score: Int {
    self.grade.score
  }
}
