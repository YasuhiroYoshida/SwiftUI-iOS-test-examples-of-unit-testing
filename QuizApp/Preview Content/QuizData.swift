//
//  QuizData.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 10/22/21.
//

import Foundation

class QuizData {
    
    static func loadQuizDTOs() -> [QuizDTO] {
        
        // read the json file
        guard let path = Bundle.main.path(forResource: "quizes", ofType: "json") else {
            fatalError("Path for quizes.json was not found")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Unable to load data!")
        }
        
        guard let quizesDTO = try? JSONDecoder().decode([QuizDTO].self, from: data) else {
            fatalError("Unable to decode data!")
        }
        
        return quizesDTO
    }

    
    static func loadQuizes() -> [QuizViewModel] {
        
        let quizesDTO = loadQuizDTOs() 
        
        return quizesDTO.map(QuizViewModel.init)
    }
    
}
