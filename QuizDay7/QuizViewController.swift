//
//  QuizViewController2.swift
//  QuizView
//
//  Created by Taof on 6/24/20.
//  Copyright © 2020 taoquynh. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        // khoá chế độ edit
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 24)
        return textView
    }()
    
    let answerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // khai báo biến lấy bộ câu hỏi
    var questions: [Question] = quizData
    
    // khai báo biến để đếm tổng số câu hỏi
    var numberOfQuestion: Int {
        return questions.count
    }
    
    // khai báo biến để biết câu hiện tại
    var currentIndexQuestion: Int = 0
    
    // khai báo biến để lấy giá trị câu hiện tại
    var currentQuestion: Question{
        return questions[currentIndexQuestion]
    }
    
    // đếm số câu đáp án của từng câu hỏi
    var countOption: Int?
    var answers: [CustomAnswerView] = []
    var timer: Timer!
    var tongTG = 60
    var dem = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = currentQuestion.question
        setupLayout()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nextQuestion))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(previousQuestion))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        dem = tongTG
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
    
    @objc func runTimer(){
        dem -= 1
        print(dem)
        if dem == 0 {
            timer.invalidate()
            print("Het thoi gian lam bai!")
        }
    }
    
    @objc func nextQuestion(){
        if currentIndexQuestion != numberOfQuestion - 1 {
            print("next cau hoi")
            next()
        } else {
            print("da het cau hoi")
            var point = 0
            for item in questions {
                for (index, j) in item.answers.enumerated() {
                    if j.isSelected && item.indexRightAnswer - 1 == index {
                        // phần này kiểm tra câu đúng
                        // nếu index câu trả lời người dùng chọn mà bằng với giá trị indexRight
                        //                        point += 1 // muốn dùng point phải khai báo
                        
                        point += 1
                    }
                }
            }
            print("\(point)/\(numberOfQuestion)")
        }
    }
    
    @objc func previousQuestion(){
        if currentIndexQuestion > 0 {
            previous()
        }
    }
    
    func next(){
        print("nextAnswer")
        // mỗi lần next, giá trị câu hỏi hiện tại tăng lên 1
        currentIndexQuestion += 1
        reloadDataQuiz()
    }
    
    func previous(){
        print("previousAnswer")
        // mỗi lần back thì câu hỏi hiện tại trừ 1
        currentIndexQuestion -= 1
        reloadDataQuiz()
    }
    
    // hàm này chạy xong thì mọi thứ layout sẽ được dựng xong
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reloadDataQuiz()
    }
    
    func setupLayout(){
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/5).isActive = true
        
        view.addSubview(answerView)
        answerView.topAnchor.constraint(equalTo: textView.bottomAnchor,constant: 10).isActive = true
        answerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        answerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        answerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    func setupAnswerView(_ question: Question){
        for i in answerView.subviews {
            // hàm removeFromSuperView để xoá các view con đã được thêm ra khỏi superview (view cha)
            i.removeFromSuperview()
        }
        
        answers.removeAll()
        
        
        let heightAnswer = answerView.bounds.height / CGFloat(question.answers.count)
        for (index, item) in question.answers.enumerated() {
            
            
            let answer = CustomAnswerView(frame: CGRect(x: 0,
                                                        y: heightAnswer*CGFloat(index),
                                                        width: answerView.bounds.width,
                                                        height: heightAnswer))
            answer.answer = item
            answerView.addSubview(answer)
            answers.append(answer)
            
        }
    }
    
    func reloadDataQuiz(){
        textView.text = currentQuestion.question
        setupAnswerView(currentQuestion)
        
        for (index, item) in answers.enumerated() {
            item.passAction = { [weak self] in
                guard let newSelf = self else { return }
                
                for i in 0..<newSelf.currentQuestion.answers.count {
                    newSelf.questions[newSelf.currentIndexQuestion].answers[i].isSelected = false
                }
                
                newSelf.questions[newSelf.currentIndexQuestion].answers[index].isSelected = true
                newSelf.reloadDataQuiz()
            }
        }
    }
    
}
