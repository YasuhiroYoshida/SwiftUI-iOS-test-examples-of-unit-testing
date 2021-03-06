//
//  QuizListScreen.swift
//  QuizApp
//
//  Created by Yasuhiro Yoshida on 10/21/21.
//

import SwiftUI

struct QuizListScreen: View {
    
    @State private var isActive: Bool = false
    @StateObject private var quizzesListVM = QuizListViewModel(networkService: NetworkServiceFactory.create())
    @State private var selectedQuiz: QuizViewModel?

    var body: some View {
        
        NavigationView {
            
            List(quizzesListVM.quizes) { quiz in
               
                NavigationLink(tag: quiz, selection: $selectedQuiz) {
                    QuestionListScreen(quiz: quiz, quizSubmission: QuizSubmission(quizId: quiz.quizId))
                } label: {
                    Text(quiz.title)
                }

            }
            .accessibilityIdentifier("quizzesList")
            .onAppear {
                quizzesListVM.populateAllQuizes()
            }
            .navigationTitle("Quizes")
        }.environment(\.rootPresentationMode, $selectedQuiz)
    }
}

struct QuizListScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizListScreen()
    }
}
